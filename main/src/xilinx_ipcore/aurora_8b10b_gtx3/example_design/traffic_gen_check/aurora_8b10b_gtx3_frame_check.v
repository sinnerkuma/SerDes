// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//

//
//  FRAME CHECK
//
//
//
//  Description: This module is a  pattern checker to test the Aurora
//               designs in hardware. The frames generated by FRAME_GEN
//               pass through the Aurora channel and arrive at the frame checker
//               through the RX User interface. Every time an error is found in
//               the data recieved, the error count is incremented until it
//               reaches its max value.

`timescale 1 ns / 1 ps
`define DLY #1

module aurora_8b10b_gtx3_FRAME_CHECK
(
    // User Interface
    RX_D, 
    RX_REM,    
    RX_SOF_N,      
    RX_EOF_N,
    RX_SRC_RDY_N,

    // System Interface
    USER_CLK,      
    RESET,
    CHANNEL_UP,

    ERR_COUNT
);

//***********************************Port Declarations*******************************

   // User Interface
    input   [0:15]     RX_D;
    input              RX_REM;
    input              RX_SOF_N;
    input              RX_EOF_N;
    input              RX_SRC_RDY_N;

   
      // System Interface
    input              USER_CLK;
    input              RESET;
    input              CHANNEL_UP;

    output  [0:7]      ERR_COUNT;
//***************************Internal Register Declarations***************************
// Slack registers
    reg   [0:15]     RX_D_SLACK;
    reg              RX_REM_1SLACK;
    reg              RX_REM_2SLACK;
    reg              RX_SOF_N_SLACK;
    reg              RX_EOF_N_SLACK;
    reg              RX_SRC_RDY_N_SLACK;

   
    reg     [0:8]      err_count_r = 9'd0;
    reg                data_in_frame_r;
    reg                data_valid_r;
    reg     [0:15]     RX_D_R;
    reg     [0:15]     pdu_cmp_data_r;
    // RX Data registers
    reg     [0:15]     data_lfsr_r;

   
//*********************************Wire Declarations**********************************
  
    wire               reset_c;
    wire    [0:15]     data_lfsr_concat_w;
    wire               data_valid_c;
    wire               data_in_frame_c;

   
    wire               data_err_detected_c;
    reg                data_err_detected_r;

   
//*********************************Main Body of Code**********************************

  //Generate RESET signal when Aurora channel is not ready
  assign reset_c = RESET;

// SLACK registers

always @ (posedge USER_CLK)
begin
  RX_D_SLACK          <= `DLY RX_D;
  RX_SRC_RDY_N_SLACK  <= `DLY RX_SRC_RDY_N;
  RX_REM_1SLACK       <= `DLY RX_REM;
  RX_REM_2SLACK       <= `DLY RX_REM;
  RX_SOF_N_SLACK      <= `DLY RX_SOF_N;
  RX_EOF_N_SLACK      <= `DLY RX_EOF_N;
end

    //______________________________ Capture incoming data ___________________________   
    //Data is valid when RX_SRC_RDY_N is asserted and data is arriving within a frame
    assign  data_valid_c    =   data_in_frame_c && !RX_SRC_RDY_N_SLACK;

    //Data is in a frame if it is a single cycle frame or a multi_cycle frame has started
    assign  data_in_frame_c  =   data_in_frame_r  ||  (!RX_SRC_RDY_N_SLACK && !RX_SOF_N_SLACK);

    //RX Data in the pdu_cmp_data_r register is valid
    //only if it was valid when captured and had no error
    always @(posedge USER_CLK)
        if(reset_c)  
           data_valid_r    <=  `DLY    1'b0;
        else if(CHANNEL_UP)
           data_valid_r    <=  `DLY    data_valid_c && !data_err_detected_c;
        else
           data_valid_r    <=  `DLY    1'b0;
   
    //Start a multicycle frame when a frame starts without ending on the same cycle. End
    //the frame when an EOF is detected
    always @(posedge USER_CLK)
        if(reset_c)  
            data_in_frame_r  <=  `DLY    1'b0;
        else if(CHANNEL_UP)
        begin
          if(!data_in_frame_r && !RX_SOF_N_SLACK && !RX_SRC_RDY_N_SLACK && RX_EOF_N_SLACK)
            data_in_frame_r  <=  `DLY    1'b1;
          else if(data_in_frame_r && !RX_SRC_RDY_N_SLACK && !RX_EOF_N_SLACK)
            data_in_frame_r  <=  `DLY    1'b0;
        end

    //Register and decode the RX_D data with RX_REM bus
    always @ (posedge USER_CLK)
    begin 	      
      if((!RX_EOF_N_SLACK) && (!RX_SRC_RDY_N_SLACK))
      begin	
        case(RX_REM_1SLACK)
          1'd0 : RX_D_R <=  `DLY {RX_D_SLACK[0:7], 8'b0};
          1'd1 : RX_D_R <=  `DLY RX_D_SLACK;
          default : RX_D_R  <=  `DLY RX_D_SLACK; 		
	endcase 	
      end 
      else if(!RX_SRC_RDY_N_SLACK)
        RX_D_R          <=  `DLY    RX_D_SLACK;
    end

    //Calculate the expected frame data
    always @ (posedge USER_CLK)
    begin
      if(reset_c)
        pdu_cmp_data_r <= `DLY {1{16'hD5E6}};
      else if(CHANNEL_UP)
      begin
        if(data_valid_c && !RX_EOF_N_SLACK)
        begin		
          case(RX_REM_2SLACK)
            1'd0 : pdu_cmp_data_r <=  `DLY {data_lfsr_concat_w[0:7], 8'b0};
            1'd1 : pdu_cmp_data_r <=  `DLY data_lfsr_concat_w;
            default : pdu_cmp_data_r <=  `DLY data_lfsr_concat_w; 		
	  endcase 	
        end
        else if(data_valid_c)
          pdu_cmp_data_r <=  `DLY data_lfsr_concat_w; 		
      end
    end


    //generate expected RX_D using LFSR
    always @(posedge USER_CLK)
        if(reset_c)
        begin
           data_lfsr_r          <=  `DLY    16'hD5E6;  //random seed value
        end
        else if(CHANNEL_UP)
        begin
          if(data_valid_c)
           data_lfsr_r          <=  `DLY    {!{data_lfsr_r[3]^data_lfsr_r[12]^data_lfsr_r[14]^data_lfsr_r[15]},
                                data_lfsr_r[0:14]};
        end
        else 
        begin
           data_lfsr_r          <=  `DLY    16'hD5E6;  //random seed value
        end

    assign data_lfsr_concat_w = {1{data_lfsr_r}};

    //___________________________ Check incoming data for errors __________________________
        
   
    //An error is detected when LFSR generated RX data from the pdu_cmp_data_r register,
    //does not match valid data from the RX_D port
    assign  data_err_detected_c    = (data_valid_r && (RX_D_R != pdu_cmp_data_r));


    //We register the data_err_detected_c signal for use with the error counter logic
    always @(posedge USER_CLK)
      data_err_detected_r    <=  `DLY    data_err_detected_c; 


    //Compare the incoming data with calculated expected data.
    //Increment the ERROR COUNTER if mismatch occurs.
    //Stop the ERROR COUNTER once it reaches its max value (i.e. 255)
    always @(posedge USER_CLK)
        if(CHANNEL_UP)
        begin
          if(&err_count_r)
            err_count_r       <=  `DLY    err_count_r;
          else if(data_err_detected_r)
            err_count_r       <=  `DLY    err_count_r + 1;
        end
	else
        begin	       	
          err_count_r       <=  `DLY    9'd0;
	end   

    //Here we connect the lower 8 bits of the count (the MSbit is used only to check when the counter reaches
    //max value) to the module output
    assign  ERR_COUNT =   err_count_r[1:8];

endmodule          

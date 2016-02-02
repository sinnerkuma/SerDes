///////////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////////
//
//  TX_LL
//
//
//  Description: The TX_LL module converts user data from the LocalLink interface
//               to Aurora Data, then sends it to the Aurora Channel for transmission.
//               It also handles NFC and UFC messages.
//
//               This module supports 1 2-byte lane designs
//

`timescale 1 ns / 1 ps

module aurora_8b10b_gtx6_TX_LL
(
    // LocalLink PDU Interface
    TX_D,
    TX_REM,
    TX_SRC_RDY_N,
    TX_SOF_N,
    TX_EOF_N,

    TX_DST_RDY_N,




    // Clock Compensation Interface
    WARN_CC,
    DO_CC,


    // Global Logic Interface
    CHANNEL_UP,


    // Aurora Lane Interface
    GEN_SCP,
    GEN_ECP,
    TX_PE_DATA_V,
    GEN_PAD,
    TX_PE_DATA,
    GEN_CC,


    // System Interface
    USER_CLK


);

`define DLY #1


//***********************************Port Declarations*******************************


    // LocalLink PDU Interface
    input   [0:15]     TX_D;
    input              TX_REM;
    input              TX_SRC_RDY_N;
    input              TX_SOF_N;
    input              TX_EOF_N;

    output             TX_DST_RDY_N;


    // Clock Compensation Interface
    input              WARN_CC;
    input              DO_CC;


    // Global Logic Interface
    input              CHANNEL_UP;


    // Aurora Lane Interface
    output             GEN_SCP;
    output             GEN_ECP;
    output             TX_PE_DATA_V;
    output             GEN_PAD;
    output  [0:15]     TX_PE_DATA;
    output             GEN_CC;


    // System Interface
    input              USER_CLK;



//*********************************Wire Declarations**********************************

    wire               halt_c_i;
    wire               tx_dst_rdy_n_i;


//*********************************Main Body of Code**********************************


    // TX_DST_RDY_N is generated by TX_LL_CONTROL and used by TX_LL_DATAPATH and
    // external modules to regulate incoming pdu data signals.
    assign  TX_DST_RDY_N    =   tx_dst_rdy_n_i;


    // TX_LL_Datapath module
    aurora_8b10b_gtx6_TX_LL_DATAPATH tx_ll_datapath_i
    (
        // LocalLink PDU Interface
        .TX_D(TX_D),
        .TX_REM(TX_REM),
        .TX_SRC_RDY_N(TX_SRC_RDY_N),
        .TX_SOF_N(TX_SOF_N),
        .TX_EOF_N(TX_EOF_N),



        // Aurora Lane Interface
        .TX_PE_DATA_V(TX_PE_DATA_V),
        .GEN_PAD(GEN_PAD),
        .TX_PE_DATA(TX_PE_DATA),


        // TX_LL Control Module Interface
        .HALT_C(halt_c_i),
        .TX_DST_RDY_N(tx_dst_rdy_n_i),


        // System Interface
        .CHANNEL_UP(CHANNEL_UP),
        .USER_CLK(USER_CLK)

    );



    // TX_LL_Control module

    aurora_8b10b_gtx6_TX_LL_CONTROL tx_ll_control_i
    (
        // LocalLink PDU Interface
        .TX_SRC_RDY_N(TX_SRC_RDY_N),
        .TX_SOF_N(TX_SOF_N),
        .TX_EOF_N(TX_EOF_N),
        .TX_REM(TX_REM),

        .TX_DST_RDY_N(tx_dst_rdy_n_i),


        // Clock Compensation Interface
        .WARN_CC(WARN_CC),
        .DO_CC(DO_CC),

        // Global Logic Interface
        .CHANNEL_UP(CHANNEL_UP),

        // TX_LL Control Module Interface
        .HALT_C(halt_c_i),


        // Aurora Lane Interface
        .GEN_SCP(GEN_SCP),
        .GEN_ECP(GEN_ECP),
        .GEN_CC(GEN_CC),


        // System Interface
        .USER_CLK(USER_CLK)

    );

endmodule

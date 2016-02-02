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
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define DLY #1

//***************************** Entity Declaration ****************************

module aurora_8b10b_gtx2_multi_gt #
(
    // Simulation attributes
    parameter   WRAPPER_SIM_GTRESET_SPEEDUP    =   "false",     // Set to "true" to speed up sim reset
    parameter   RX_DFE_KL_CFG2_IN              =   32'h3010D90C,
    parameter   PMA_RSV_IN                     =   32'h00018480,
    parameter   SIM_VERSION                    =   "3.0"
)
(
    //_________________________________________________________________________
    //_________________________________________________________________________
    //GT0  
    //____________________________CHANNEL PORTS________________________________
    //-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
    input   [8:0]   GT0_DRPADDR_IN,
    input           GT0_DRPCLK_IN,
    input   [15:0]  GT0_DRPDI_IN,
    output  [15:0]  GT0_DRPDO_OUT,
    input           GT0_DRPEN_IN,
    output          GT0_DRPRDY_OUT,
    input           GT0_DRPWE_IN,
    //----------------------- Channel - Ref Clock Ports ------------------------
    input           GT0_GTREFCLK0_IN,
    //------------------------------ Channel PLL -------------------------------
    output          GT0_CPLLFBCLKLOST_OUT,
    output          GT0_CPLLLOCK_OUT,
    input           GT0_CPLLLOCKDETCLK_IN,
    output          GT0_CPLLREFCLKLOST_OUT,
    input           GT0_CPLLRESET_IN,
    //----------------------------- Eye Scan Ports -----------------------------
    output          GT0_EYESCANDATAERROR_OUT,
    //---------------------- Loopback and Powerdown Ports ----------------------
    input   [2:0]   GT0_LOOPBACK_IN,
    input   [1:0]   GT0_RXPD_IN,
    input   [1:0]   GT0_TXPD_IN,
    //----------------------------- Receive Ports ------------------------------
    input           GT0_RXUSERRDY_IN,
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    output  [1:0]   GT0_RXCHARISCOMMA_OUT,
    output  [1:0]   GT0_RXCHARISK_OUT,
    output  [1:0]   GT0_RXDISPERR_OUT,
    output  [1:0]   GT0_RXNOTINTABLE_OUT,
    //----------------- Receive Ports - Clock Correction Ports -----------------
    output  [1:0]   GT0_RXCLKCORCNT_OUT,
    //------------- Receive Ports - Comma Detection and Alignment --------------
    output          GT0_RXBYTEREALIGN_OUT,
    input           GT0_RXMCOMMAALIGNEN_IN,
    input           GT0_RXPCOMMAALIGNEN_IN,
    //----------------- Receive Ports - RX Data Path interface -----------------
    input           GT0_GTRXRESET_IN,
    output  [15:0]  GT0_RXDATA_OUT,
    output          GT0_RXOUTCLK_OUT,
    input           GT0_RXUSRCLK_IN,
    input           GT0_RXUSRCLK2_IN,
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    input           GT0_GTXRXN_IN,
    input           GT0_GTXRXP_IN,
    output          GT0_RXCDRLOCK_OUT,
    output          GT0_RXELECIDLE_OUT,
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    output  [2:0]   GT0_RXBUFSTATUS_OUT,
    //---------------------- Receive Ports - RX PLL Ports ----------------------
    output          GT0_RXRESETDONE_OUT,
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    input           GT0_RXPOLARITY_IN,
    //----------------------------- Transmit Ports -----------------------------
    input           GT0_TXUSERRDY_IN,
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    input   [1:0]   GT0_TXCHARISK_IN,
    //---------- Transmit Ports - TX Buffer and Phase Alignment Ports ----------
    output  [1:0]   GT0_TXBUFSTATUS_OUT,
    //---------------- Transmit Ports - TX Data Path interface -----------------
    input           GT0_GTTXRESET_IN,
    input   [15:0]  GT0_TXDATA_IN,
    output          GT0_TXOUTCLK_OUT,
    output          GT0_TXOUTCLKFABRIC_OUT,
    output          GT0_TXOUTCLKPCS_OUT,
    input           GT0_TXUSRCLK_IN,
    input           GT0_TXUSRCLK2_IN,
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    output          GT0_GTXTXN_OUT,
    output          GT0_GTXTXP_OUT,
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    output          GT0_TXRESETDONE_OUT,


    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    input           GT0_GTREFCLK0_COMMON_IN,
    //----------------------- Common Block - QPLL Ports ------------------------
    output          GT0_QPLLLOCK_OUT,
    input           GT0_QPLLLOCKDETCLK_IN,
    output          GT0_QPLLREFCLKLOST_OUT,
    input           GT0_QPLLRESET_IN


);
//***************************** Parameter Declarations ************************
    parameter QPLL_FBDIV_TOP =  40;

    parameter QPLL_FBDIV_IN  =  (QPLL_FBDIV_TOP == 16)  ? 10'b0000100000 : 
				(QPLL_FBDIV_TOP == 20)  ? 10'b0000110000 :
				(QPLL_FBDIV_TOP == 32)  ? 10'b0001100000 :
				(QPLL_FBDIV_TOP == 40)  ? 10'b0010000000 :
				(QPLL_FBDIV_TOP == 64)  ? 10'b0011100000 :
				(QPLL_FBDIV_TOP == 66)  ? 10'b0101000000 :
				(QPLL_FBDIV_TOP == 80)  ? 10'b0100100000 :
				(QPLL_FBDIV_TOP == 100) ? 10'b0101110000 : 10'b0000000000;

   parameter QPLL_FBDIV_RATIO = (QPLL_FBDIV_TOP == 16)  ? 1'b1 : 
				(QPLL_FBDIV_TOP == 20)  ? 1'b1 :
				(QPLL_FBDIV_TOP == 32)  ? 1'b1 :
				(QPLL_FBDIV_TOP == 40)  ? 1'b1 :
				(QPLL_FBDIV_TOP == 64)  ? 1'b1 :
				(QPLL_FBDIV_TOP == 66)  ? 1'b0 :
				(QPLL_FBDIV_TOP == 80)  ? 1'b1 :
				(QPLL_FBDIV_TOP == 100) ? 1'b1 : 1'b1;

//***************************** Wire Declarations *****************************

    // ground and vcc signals
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [63:0]  tied_to_vcc_vec_i;
    
// QPLL wires
   wire                     gt_qpllclk_quad2_i;
   wire                     gt_qpllrefclk_quad2_i;
         
//********************************* Main Body of Code**************************

    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 64'hffffffffffffffff;


//------------------------- GT Instances  -------------------------------
    //_________________________________________________________________________
    //_________________________________________________________________________
    //GT0

    aurora_8b10b_gtx2_gt #
    (
        // Simulation attributes
        .GT_SIM_GTRESET_SPEEDUP   (WRAPPER_SIM_GTRESET_SPEEDUP),
        .SIM_VERSION              (SIM_VERSION),
        .RX_DFE_KL_CFG2_IN        (RX_DFE_KL_CFG2_IN),
        .PCS_RSVD_ATTR_IN         (48'h000000000000),
        .PMA_RSV_IN               (PMA_RSV_IN)
    )
    gt0_aurora_8b10b_gtx2_i
    (
        //-------------------------------- Channel ---------------------------------
        .QPLLCLK_IN                     (gt_qpllclk_quad2_i),
        .QPLLREFCLK_IN                  (gt_qpllrefclk_quad2_i),
        //-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
        .DRPADDR_IN                     (GT0_DRPADDR_IN),
        .DRPCLK_IN                      (GT0_DRPCLK_IN),
        .DRPDI_IN                       (GT0_DRPDI_IN),
        .DRPDO_OUT                      (GT0_DRPDO_OUT),
        .DRPEN_IN                       (GT0_DRPEN_IN),
        .DRPRDY_OUT                     (GT0_DRPRDY_OUT),
        .DRPWE_IN                       (GT0_DRPWE_IN),
        //----------------------- Channel - Ref Clock Ports ------------------------
        .GTREFCLK0_IN                   (GT0_GTREFCLK0_IN),
        //------------------------------ Channel PLL -------------------------------
        .CPLLFBCLKLOST_OUT              (GT0_CPLLFBCLKLOST_OUT),
        .CPLLLOCK_OUT                   (GT0_CPLLLOCK_OUT),
        .CPLLLOCKDETCLK_IN              (GT0_CPLLLOCKDETCLK_IN),
        .CPLLREFCLKLOST_OUT             (GT0_CPLLREFCLKLOST_OUT),
        .CPLLRESET_IN                   (GT0_CPLLRESET_IN),
        //----------------------------- Eye Scan Ports -----------------------------
        .EYESCANDATAERROR_OUT           (GT0_EYESCANDATAERROR_OUT),
        //---------------------- Loopback and Powerdown Ports ----------------------
        .LOOPBACK_IN                    (GT0_LOOPBACK_IN),
        .RXPD_IN                        (GT0_RXPD_IN),
        .TXPD_IN                        (GT0_TXPD_IN),
        //----------------------------- Receive Ports ------------------------------
        .RXUSERRDY_IN                   (GT0_RXUSERRDY_IN),
        //--------------------- Receive Ports - 8b10b Decoder ----------------------
        .RXCHARISCOMMA_OUT              (GT0_RXCHARISCOMMA_OUT),
        .RXCHARISK_OUT                  (GT0_RXCHARISK_OUT),
        .RXDISPERR_OUT                  (GT0_RXDISPERR_OUT),
        .RXNOTINTABLE_OUT               (GT0_RXNOTINTABLE_OUT),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .RXCLKCORCNT_OUT                (GT0_RXCLKCORCNT_OUT),
        //------------- Receive Ports - Comma Detection and Alignment --------------
        .RXBYTEREALIGN_OUT              (GT0_RXBYTEREALIGN_OUT),
        .RXMCOMMAALIGNEN_IN             (GT0_RXMCOMMAALIGNEN_IN),
        .RXPCOMMAALIGNEN_IN             (GT0_RXPCOMMAALIGNEN_IN),
        //----------------- Receive Ports - RX Data Path interface -----------------
        .GTRXRESET_IN                   (GT0_GTRXRESET_IN),
        .RXDATA_OUT                     (GT0_RXDATA_OUT),
        .RXOUTCLK_OUT                   (GT0_RXOUTCLK_OUT),
        .RXUSRCLK_IN                    (GT0_RXUSRCLK_IN),
        .RXUSRCLK2_IN                   (GT0_RXUSRCLK2_IN),
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GTXRXN_IN                      (GT0_GTXRXN_IN),
        .GTXRXP_IN                      (GT0_GTXRXP_IN),
        .RXCDRLOCK_OUT                  (GT0_RXCDRLOCK_OUT),
        .RXELECIDLE_OUT                 (GT0_RXELECIDLE_OUT),
        //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        .RXBUFSTATUS_OUT                (GT0_RXBUFSTATUS_OUT),
        //---------------------- Receive Ports - RX PLL Ports ----------------------
        .RXRESETDONE_OUT                (GT0_RXRESETDONE_OUT),
        //--------------- Receive Ports - RX Polarity Control Ports ----------------
        .RXPOLARITY_IN                  (GT0_RXPOLARITY_IN),
        //----------------------------- Transmit Ports -----------------------------
        .TXUSERRDY_IN                   (GT0_TXUSERRDY_IN),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .TXCHARISK_IN                   (GT0_TXCHARISK_IN),
        //---------- Transmit Ports - TX Buffer and Phase Alignment Ports ----------
        .TXBUFSTATUS_OUT                (GT0_TXBUFSTATUS_OUT),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GTTXRESET_IN                   (GT0_GTTXRESET_IN),
        .TXDATA_IN                      (GT0_TXDATA_IN),
        .TXOUTCLK_OUT                   (GT0_TXOUTCLK_OUT),
        .TXOUTCLKFABRIC_OUT             (GT0_TXOUTCLKFABRIC_OUT),
        .TXOUTCLKPCS_OUT                (GT0_TXOUTCLKPCS_OUT),
        .TXUSRCLK_IN                    (GT0_TXUSRCLK_IN),
        .TXUSRCLK2_IN                   (GT0_TXUSRCLK2_IN),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GTXTXN_OUT                     (GT0_GTXTXN_OUT),
        .GTXTXP_OUT                     (GT0_GTXTXP_OUT),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .TXRESETDONE_OUT                (GT0_TXRESETDONE_OUT)

    );


    //_________________________________________________________________________
    //_________________________________________________________________________
    //_________________________GTXE2_COMMON____________________________________

    GTXE2_COMMON #
    (
            // Simulation attributes
            .SIM_RESET_SPEEDUP   (WRAPPER_SIM_GTRESET_SPEEDUP),
            .SIM_QPLLREFCLK_SEL  (3'b001),
            .SIM_VERSION         ("4.0"),


           //----------------COMMON BLOCK Attributes---------------
            .BIAS_CFG                               (64'h0000040000001000),
            .COMMON_CFG                             (32'h00000000),
            .QPLL_CFG                               (27'h06801C1),
            .QPLL_CLKOUT_CFG                        (4'b0000),
            .QPLL_COARSE_FREQ_OVRD                  (6'b010000),
            .QPLL_COARSE_FREQ_OVRD_EN               (1'b0),
            .QPLL_CP                                (10'b0000011111),
            .QPLL_CP_MONITOR_EN                     (1'b0),
            .QPLL_DMONITOR_SEL                      (1'b0),
            .QPLL_FBDIV                             (QPLL_FBDIV_IN),
            .QPLL_FBDIV_MONITOR_EN                  (1'b0),
            .QPLL_FBDIV_RATIO                       (QPLL_FBDIV_RATIO),
            .QPLL_INIT_CFG                          (24'h000006),
            .QPLL_LOCK_CFG                          (16'h21E8),
            .QPLL_LPF                               (4'b1111),
            .QPLL_REFCLK_DIV                        (1)

    )
    gtxe2_common_i
    (
        //----------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
        .DRPADDR                        (tied_to_ground_vec_i[7:0]),
        .DRPCLK                         (tied_to_ground_i),
        .DRPDI                          (tied_to_ground_vec_i[15:0]),
        .DRPDO                          (),
        .DRPEN                          (tied_to_ground_i),
        .DRPRDY                         (),
        .DRPWE                          (tied_to_ground_i),
        //-------------------- Common Block  - Ref Clock Ports ---------------------
        .GTGREFCLK                      (tied_to_ground_i),
        .GTNORTHREFCLK0                 (tied_to_ground_i),
        .GTNORTHREFCLK1                 (tied_to_ground_i),
        .GTREFCLK0                      (GT0_GTREFCLK0_COMMON_IN),
        .GTREFCLK1                      (tied_to_ground_i),
        .GTSOUTHREFCLK0                 (tied_to_ground_i),
        .GTSOUTHREFCLK1                 (tied_to_ground_i),
        //----------------------- Common Block - QPLL Ports ------------------------
        .QPLLDMONITOR                   (),
        .QPLLFBCLKLOST                  (),
        .QPLLLOCK                       (GT0_QPLLLOCK_OUT),
        .QPLLLOCKDETCLK                 (GT0_QPLLLOCKDETCLK_IN),
        .QPLLLOCKEN                     (tied_to_vcc_i),
        .QPLLOUTCLK                     (gt_qpllclk_quad2_i),
        .QPLLOUTREFCLK                  (gt_qpllrefclk_quad2_i),
        .QPLLOUTRESET                   (tied_to_ground_i),
        .QPLLPD                         (tied_to_ground_i),
        .QPLLREFCLKLOST                 (GT0_QPLLREFCLKLOST_OUT),
        .QPLLREFCLKSEL                  (3'b001),
        .QPLLRESET                      (GT0_QPLLRESET_IN),
        .QPLLRSVD1                      (16'b0000000000000000),
        .QPLLRSVD2                      (5'b11111),
        .REFCLKOUTMONITOR               (),
        //--------------------------- Common Block Ports ---------------------------
        .BGBYPASSB                      (tied_to_vcc_i),
        .BGMONITORENB                   (tied_to_vcc_i),
        .BGPDB                          (tied_to_vcc_i),
        .BGRCALOVRD                     (5'b00000),
        .PMARSVD                        (8'b00000000),
        .RCALENB                        (tied_to_vcc_i)

    );



endmodule

   

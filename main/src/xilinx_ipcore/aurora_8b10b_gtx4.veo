


//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
// Instantiate the module
aurora_8b10b_gtx4 instance_name (
    .S_AXI_TX_TDATA(S_AXI_TX_TDATA), 
    .S_AXI_TX_TKEEP(S_AXI_TX_TKEEP), 
    .S_AXI_TX_TVALID(S_AXI_TX_TVALID), 
    .S_AXI_TX_TLAST(S_AXI_TX_TLAST), 
    .S_AXI_TX_TREADY(S_AXI_TX_TREADY), 
    .M_AXI_RX_TDATA(M_AXI_RX_TDATA), 
    .M_AXI_RX_TKEEP(M_AXI_RX_TKEEP), 
    .M_AXI_RX_TVALID(M_AXI_RX_TVALID), 
    .M_AXI_RX_TLAST(M_AXI_RX_TLAST), 
    .RXP(RXP), 
    .RXN(RXN), 
    .TXP(TXP), 
    .TXN(TXN), 
    .GT_REFCLK1(GT_REFCLK1), 
    .HARD_ERR(HARD_ERR), 
    .SOFT_ERR(SOFT_ERR), 
    .FRAME_ERR(FRAME_ERR), 
    .CHANNEL_UP(CHANNEL_UP), 
    .LANE_UP(LANE_UP), 
    .WARN_CC(WARN_CC), 
    .DO_CC(DO_CC), 
    .USER_CLK(USER_CLK), 
    .SYNC_CLK(SYNC_CLK), 
    .RESET(RESET), 
    .POWER_DOWN(POWER_DOWN), 
    .LOOPBACK(LOOPBACK), 
    .GT_RESET(GT_RESET), 
    .LINK_RESET_OUT(LINK_RESET_OUT), 
    .INIT_CLK_IN(INIT_CLK_IN), 
    .PLL_NOT_LOCKED(PLL_NOT_LOCKED), 
    .TX_RESETDONE_OUT(TX_RESETDONE_OUT), 
    .RX_RESETDONE_OUT(RX_RESETDONE_OUT), 
    .DRPADDR_IN(DRPADDR_IN), 
    .DRPCLK_IN(DRPCLK_IN), 
    .DRPDI_IN(DRPDI_IN), 
    .DRPDO_OUT(DRPDO_OUT), 
    .DRPEN_IN(DRPEN_IN), 
    .DRPRDY_OUT(DRPRDY_OUT), 
    .DRPWE_IN(DRPWE_IN), 
    .TX_OUT_CLK(TX_OUT_CLK), 
    .TX_LOCK(TX_LOCK)
    );


// INST_TAG_END ------ End INSTANTIATION Template ---------
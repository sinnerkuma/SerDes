# SimVision Command Script

#
# groups
#

if {[catch {group new -name {System Signals} -overlay 0}] != ""} {
    group using {System Signals}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.reset \
    :demo_tb.gtx_clk

if {[catch {group new -name {TX MAC Interface} -overlay 0}] != ""} {
    group using {TX MAC Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.trimac_fifo_block.tx_mac_resetn \
    :demo_tb.dut.trimac_fifo_block.tx_axis_mac_tvalid \
    :demo_tb.dut.trimac_fifo_block.tx_axis_mac_tdata \
    :demo_tb.dut.trimac_fifo_block.tx_axis_mac_tready \
    :demo_tb.dut.trimac_fifo_block.tx_axis_mac_tlast \
    :demo_tb.dut.trimac_fifo_block.tx_axis_mac_tuser
    

if {[catch {group new -name {TX Statistics Vector} -overlay 0}] != ""} {
    group using {TX Statistics Vector}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.tx_statistics_vector \
    :demo_tb.dut.tx_statistics_valid

if {[catch {group new -name {RX MAC Interface} -overlay 0}] != ""} {
    group using {RX MAC Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.trimac_fifo_block.rx_mac_aclk \
    :demo_tb.dut.trimac_fifo_block.rx_mac_resetn \
    :demo_tb.dut.trimac_fifo_block.rx_axis_mac_tvalid \
    :demo_tb.dut.trimac_fifo_block.rx_axis_mac_tdata \
    :demo_tb.dut.trimac_fifo_block.rx_axis_mac_tlast \
    :demo_tb.dut.trimac_fifo_block.rx_axis_mac_tuser


if {[catch {group new -name {RX Statistics Vector} -overlay 0}] != ""} {
    group using {RX Statistics Vector}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.rx_statistics_vector \
    :demo_tb.dut.rx_statistics_valid


if {[catch {group new -name {Flow Control} -overlay 0}] != ""} {
    group using {Flow Control}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.pause_val \
    :demo_tb.dut.pause_req

if {[catch {group new -name {Rx FIFO Interface} -overlay 0}] != ""} {
    group using {Rx FIFO Interface}

    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.trimac_fifo_block.rx_fifo_clock \
    :demo_tb.dut.trimac_fifo_block.rx_fifo_resetn \
    :demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tdata \
    :demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tlast \
    :demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tready \
    :demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tvalid

if {[catch {group new -name {Tx FIFO Interface} -overlay 0}] != ""} {
    group using {Tx FIFO Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.trimac_fifo_block.tx_fifo_clock \
    :demo_tb.dut.trimac_fifo_block.tx_fifo_resetn \
    :demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tdata \
    :demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tlast \
    :demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tready \
    :demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tvalid

if {[catch {group new -name {TX RGMII Interface} -overlay 0}] != ""} {
    group using {TX RGMII Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.rgmii_txc \
    :demo_tb.rgmii_tx_ctl \
    :demo_tb.rgmii_txd

if {[catch {group new -name {RX RGMII Interface} -overlay 0}] != ""} {
    group using {RX RGMII Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.rgmii_rxc \
    :demo_tb.rgmii_rx_ctl \
    :demo_tb.rgmii_rxd



if {[catch {group new -name {MDIO Interface} -overlay 0}] != ""} {
    group using {MDIO Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.mdc \
    :demo_tb.mdio

if {[catch {group new -name {Configuration Interface} -overlay 0}] != ""} {
    group using {Configuration Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :demo_tb.dut.s_axi_aclk    \
    :demo_tb.dut.s_axi_awaddr  \
    :demo_tb.dut.s_axi_awvalid \
    :demo_tb.dut.s_axi_awready \
    :demo_tb.dut.s_axi_wdata   \
    :demo_tb.dut.s_axi_wvalid  \
    :demo_tb.dut.s_axi_wready  \
    :demo_tb.dut.s_axi_bresp   \
    :demo_tb.dut.s_axi_bvalid  \
    :demo_tb.dut.s_axi_bready  \
    :demo_tb.dut.s_axi_araddr  \
    :demo_tb.dut.s_axi_arvalid \
    :demo_tb.dut.s_axi_arready \
    :demo_tb.dut.s_axi_rdata   \
    :demo_tb.dut.s_axi_rresp   \
    :demo_tb.dut.s_axi_rvalid  \
    :demo_tb.dut.s_axi_rready


#
# Waveform windows
#
if {[window find -match exact -name "Waveform 1"] == {}} {
    window new WaveWindow -name "Waveform 1" -geometry 906x585+25+55
} else {
    window geometry "Waveform 1" 906x585+25+55
}
window target "Waveform 1" on
waveform using {Waveform 1}
waveform sidebar visibility partial
waveform set \
    -primarycursor TimeA \
    -signalnames name \
    -signalwidth 175 \
    -units fs \
    -valuewidth 75
cursor set -using TimeA -time 50,000,000,000fs
cursor set -using TimeA -marching 1
waveform baseline set -time 0

set groupId [waveform add -groups {{System Signals}}]
set groupId [waveform add -groups {{TX MAC Interface}}]
set groupId [waveform add -groups {{TX Statistics Vector}}]
set groupId [waveform add -groups {{RX MAC Interface}}]
set groupId [waveform add -groups {{RX Statistics Vector}}]
set groupId [waveform add -groups {{Flow Control}}]
set groupId [waveform add -groups {{Rx FIFO Interface}}]
set groupId [waveform add -groups {{Tx FIFO Interface}}]

set groupId [waveform add -groups {{TX RGMII Interface}}]
set groupId [waveform add -groups {{RX RGMII Interface}}]
set groupId [waveform add -groups {{MDIO Interface}}]
set groupId [waveform add -groups {{Configuration Interface}}]

waveform xview limits 0fs 10us

simcontrol run -time 500us

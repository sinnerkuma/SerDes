REM   ____  ____ 
REM  /   /\/   / 
REM /___/  \  /    Vendor: Xilinx 
REM \   \   \/     Version : 2.7
REM  \   \         Application : 7 Series FPGAs Transceivers Wizard
REM  /   /         Filename : simulate_isim.bat
REM /___/   /\     
REM \   \  /  \ 
REM  \___\/\___\ 
REM
REM
REM Script SIMULATE_ISIM.BAT
REM Generated by Xilinx 7 Series FPGAs Transceivers Wizard
REM
REM (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
REM
REM This file contains confidential and proprietary information
REM of Xilinx, Inc. and is protected under U.S. and
REM international copyright and other intellectual property
REM laws.
REM
REM DISCLAIMER
REM This disclaimer is not a license and does not grant any
REM rights to the materials distributed herewith. Except as
REM otherwise provided in a valid license issued to you by
REM Xilinx, and to the maximum extent permitted by applicable
REM law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
REM WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
REM AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
REM BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
REM INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
REM (2) Xilinx shall not be liable (whether in contract or tort,
REM including negligence, or under any other theory of
REM liability) for any loss or damage of any kind or nature
REM related to, arising under or in connection with these
REM materials, including for any direct, or any indirect,
REM special, incidental, or consequential loss or damage
REM (including loss of data, profits, goodwill, or any type of
REM loss or damage suffered as a result of any action brought
REM by a third party) even if such damage or loss was
REM reasonably foreseeable or Xilinx had been advised of the
REM possibility of the same.
REM
REM CRITICAL APPLICATIONS
REM Xilinx products are not designed or intended to be fail-
REM safe, or for use in any application requiring fail-safe
REM performance, such as life-support or safety devices or
REM systems, Class III medical devices, nuclear facilities,
REM applications related to the deployment of airbags, or any
REM other applications that could lead to death, personal
REM injury, or severe property or environmental damage
REM (individually and collectively, "Critical
REM Applications"). Customer assumes the sole risk and
REM liability of any use of Xilinx products in Critical
REM Applications, subject only to applicable laws and
REM regulations governing limitations on product liability.
REM 
REM THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
REM PART OF THIS FILE AT ALL TIMES.


REM***************************** Beginning of Script ***************************
        
REM Create and map work directory
mkdir work

REM Multi GT Wrapper
vlogcomp -work work  ..\..\..\gtwizard_v2_7.v
REM GT Wrapper
vlogcomp -work work  ..\..\..\gtwizard_v2_7_gt.v

vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_init.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_sync_block.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_adapt_starter.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_agc_loop_fsm.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_ctle_agc_comp.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_adapt_top_dfe.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_tx_startup_fsm.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_rx_startup_fsm.v;
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_recclk_monitor.v;







REM Clock Module
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_gt_usrclk_source.v


REM Example Design modules
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_gt_frame_gen.v
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_gt_frame_check.v
vlogcomp -work work  ..\..\example_design\gtwizard_v2_7_exdes.v



vlogcomp -work work  ..\gtwizard_v2_7_tb.v

REM Other modules
vlogcomp -work work %XILINX%\verilog\src\glbl.v

REM Load Design
fuse work.gtwizard_v2_7_TB work.glbl -L unisims_ver -L secureip -o gtwizard_v2_7_tb.exe

.\gtwizard_v2_7_tb.exe -gui -tclbatch wave_isim.tcl -wdb wave_isim  


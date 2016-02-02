
#!/bin/bash
################################################################################
##   ____  ____
##  /   /\/   /
## /___/  \  /    Vendor: Xilinx
## \   \   \/     Version : 1.11
##  \   \         Application : Spartan-6 FPGA GTP Transceiver Wizard
##  /   /         Filename : implement_synplify_sh.ejava 
## /___/   /\      
## \   \  /  \
##  \___\/\___\
##
##
## implement_synplify.sh script 
## Generated by Xilinx Spartan-6 FPGA GTP Transceiver Wizard
##


#-----------------------------------------------------------------------------
# Script to synthesize and implement the RTL provided for the wizard
#-----------------------------------------------------------------------------

##---------------------Change CWD to results-------------------------------------

#Clean results directory
#Create results directory
#Change current directory to results
echo "WARNING: Removing existing results directory"
rm -rf results
mkdir results
cp synplify.prj    ./results
cp *.ngc           ./results

##-----------------------------Run Synthesis-------------------------------------

echo "### Running Synplify Pro - "
synplify_pro -batch synplify.prj

cp s6_gtpwizard_v1_11_top.edf ./results
cd ./results

##-------------------------------Run ngdbuild---------------------------------------

echo 'Running ngdbuild'
ngdbuild -uc ../../example_design/s6_gtpwizard_v1_11_top.ucf -p xc6slx45t-fgg484-2 s6_gtpwizard_v1_11_top.edf s6_gtpwizard_v1_11_top.ngd

#end run ngdbuild section

##-------------------------------Run map-------------------------------------------

echo 'Running map'
map -register_duplication on -global_opt speed -logic_opt on -retiming on -timing -ol high -w -p xc6slx45t-fgg484-2 -o mapped.ncd s6_gtpwizard_v1_11_top.ngd

##-------------------------------Run par-------------------------------------------

echo 'Running par'
par -ol high -w mapped.ncd routed.ncd mapped.pcf

##---------------------------Report par results-------------------------------------

echo 'Running design through bitgen'
bitgen -g GWE_cycle:Done -g GTS_cycle:Done -g DriveDone:Yes -g StartupClk:Cclk -w routed.ncd

##-------------------------------Trace Report---------------------------------------

echo 'Running trce'
trce -e -l 1000 -s -2 routed -o routed mapped.pcf

##-------------------------------Run netgen------------------------------------------

echo 'Running netgen to create gate level Verilog model'
netgen -ofmt verilog -sim -sdf_path ../../implement/results -dir . -tm s6_gtpwizard_v1_11_top -w routed.ncd routed.v

#Change directory to implement

cd ..



 
 
 

 



#!/bin/sh

# Clean up the results directory
rm -rf results
mkdir results

#Synthesize the Wrapper Files

echo 'Synthesizing example design with XST';
xst -ifn xst.scr
cp sdp_ram_d1024_w36_exdes.ngc ./results/


# Copy the netlist generated by Coregen
echo 'Copying files from the netlist directory to the results directory'
cp ../../sdp_ram_d1024_w36.ngc results/

#  Copy the constraints files generated by Coregen
echo 'Copying files from constraints directory to results directory'
cp ../example_design/sdp_ram_d1024_w36_exdes.ucf results/

cd results

echo 'Running ngdbuild'
ngdbuild -p xc7k325t-ffg676-2 sdp_ram_d1024_w36_exdes

echo 'Running map'
map sdp_ram_d1024_w36_exdes -o mapped.ncd -pr i

echo 'Running par'
par mapped.ncd routed.ncd

echo 'Running trce'
trce -e 10 routed.ncd mapped.pcf -o routed

echo 'Running design through bitgen'
bitgen -w routed -g UnconstrainedPins:Allow

echo 'Running netgen to create gate level Verilog model'
netgen -ofmt verilog -sim -tm sdp_ram_d1024_w36_exdes -pcf mapped.pcf -w -sdf_anno false routed.ncd routed.v

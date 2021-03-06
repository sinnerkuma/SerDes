
The design files are located at
C:/Users/huangrui/Desktop/0530/nCAS1000_FPGA/ncas1000/src/xilinx_ipcore:

   - ddr3_pro.veo:
        veo template file containing code that can be used as a model
        for instantiating a CORE Generator module in a HDL design.

   - ddr3_pro.xco:
       CORE Generator input file containing the parameters used to
       regenerate a core.

   - ddr3_pro_flist.txt:
        Text file listing all of the output files produced when a customized
        core was generated in the CORE Generator.

   - ddr3_pro_readme.txt:
        Text file indicating the files generated and how they are used.

   - ddr3_pro_xmdf.tcl:
        ISE Project Navigator interface file. ISE uses this file to determine
        how the files output by CORE Generator for the core can be integrated
        into your ISE project.

   - ddr3_pro.gise and ddr3_pro.xise:
        ISE Project Navigator support files. These are generated files and
        should not be edited directly.

   - ddr3_pro directory.

In the ddr3_pro directory, three folders are created:
   - docs:
        This folder contains Virtex-6 FPGA Memory Interface Solutions user guide
        and data sheet.

   - example_design:
        This folder includes the design with synthesizable test bench.

   - user_design:
        This folder includes the design without test bench modules.

The example_design and user_design folders contain several other folders
and files. All these output folders are discussed in more detail in
Spartan-6 FPGA Memory Controller user guide (ug388.pdf) located in docs folder.
    
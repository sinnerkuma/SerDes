library verilog;
use verilog.vl_types.all;
entity sim_tb_top is
    generic(
        DEBUG_EN        : integer := 0;
        C1_MEMCLK_PERIOD: integer := 3000;
        C1_RST_ACT_LOW  : integer := 0;
        C1_INPUT_CLK_TYPE: string  := "SINGLE_ENDED";
        C1_NUM_DQ_PINS  : integer := 16;
        C1_MEM_ADDR_WIDTH: integer := 14;
        C1_MEM_BANKADDR_WIDTH: integer := 3;
        C1_MEM_ADDR_ORDER: string  := "BANK_ROW_COLUMN";
        C1_P0_MASK_SIZE : integer := 16;
        C1_P0_DATA_PORT_SIZE: integer := 128;
        C1_CALIB_SOFT_IP: string  := "TRUE";
        C1_SIMULATION   : string  := "TRUE";
        C1_HW_TESTING   : string  := "FALSE"
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DEBUG_EN : constant is 1;
    attribute mti_svvh_generic_type of C1_MEMCLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of C1_RST_ACT_LOW : constant is 1;
    attribute mti_svvh_generic_type of C1_INPUT_CLK_TYPE : constant is 1;
    attribute mti_svvh_generic_type of C1_NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of C1_MEM_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C1_MEM_BANKADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C1_MEM_ADDR_ORDER : constant is 1;
    attribute mti_svvh_generic_type of C1_P0_MASK_SIZE : constant is 1;
    attribute mti_svvh_generic_type of C1_P0_DATA_PORT_SIZE : constant is 1;
    attribute mti_svvh_generic_type of C1_CALIB_SOFT_IP : constant is 1;
    attribute mti_svvh_generic_type of C1_SIMULATION : constant is 1;
    attribute mti_svvh_generic_type of C1_HW_TESTING : constant is 1;
end sim_tb_top;
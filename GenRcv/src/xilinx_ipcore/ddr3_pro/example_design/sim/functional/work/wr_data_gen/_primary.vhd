library verilog;
use verilog.vl_types.all;
entity wr_data_gen is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "SPARTAN6";
        MEM_BURST_LEN   : integer := 8;
        MODE            : string  := "WR";
        ADDR_WIDTH      : integer := 32;
        BL_WIDTH        : integer := 6;
        DWIDTH          : integer := 32;
        DATA_PATTERN    : string  := "DGEN_PRBS";
        NUM_DQ_PINS     : integer := 8;
        SEL_VICTIM_LINE : integer := 3;
        COLUMN_WIDTH    : integer := 10;
        EYE_TEST        : string  := "FALSE"
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic_vector(4 downto 0);
        prbs_fseed_i    : in     vl_logic_vector(31 downto 0);
        data_mode_i     : in     vl_logic_vector(3 downto 0);
        cmd_rdy_o       : out    vl_logic;
        cmd_valid_i     : in     vl_logic;
        cmd_validB_i    : in     vl_logic;
        cmd_validC_i    : in     vl_logic;
        last_word_o     : out    vl_logic;
        fixed_data_i    : in     vl_logic_vector;
        addr_i          : in     vl_logic_vector;
        bl_i            : in     vl_logic_vector;
        data_rdy_i      : in     vl_logic;
        data_valid_o    : out    vl_logic;
        data_o          : out    vl_logic_vector;
        data_wr_end_o   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of MODE : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of SEL_VICTIM_LINE : constant is 1;
    attribute mti_svvh_generic_type of COLUMN_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of EYE_TEST : constant is 1;
end wr_data_gen;
library verilog;
use verilog.vl_types.all;
entity mcb_traffic_gen is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "SPARTAN6";
        SIMULATION      : string  := "FALSE";
        MEM_BURST_LEN   : integer := 8;
        PORT_MODE       : string  := "BI_MODE";
        DATA_PATTERN    : string  := "DGEN_ALL";
        CMD_PATTERN     : string  := "CGEN_ALL";
        ADDR_WIDTH      : integer := 30;
        CMP_DATA_PIPE_STAGES: integer := 0;
        MEM_COL_WIDTH   : integer := 10;
        NUM_DQ_PINS     : integer := 16;
        DQ_ERROR_WIDTH  : integer := 1;
        SEL_VICTIM_LINE : integer := 3;
        DWIDTH          : integer := 32;
        PRBS_EADDR_MASK_POS: vl_logic_vector(31 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        PRBS_SADDR_MASK_POS: integer := 8192;
        PRBS_EADDR      : integer := 8192;
        PRBS_SADDR      : integer := 20480;
        EYE_TEST        : string  := "FALSE"
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        run_traffic_i   : in     vl_logic;
        manual_clear_error: in     vl_logic;
        start_addr_i    : in     vl_logic_vector(31 downto 0);
        end_addr_i      : in     vl_logic_vector(31 downto 0);
        cmd_seed_i      : in     vl_logic_vector(31 downto 0);
        data_seed_i     : in     vl_logic_vector(31 downto 0);
        load_seed_i     : in     vl_logic;
        addr_mode_i     : in     vl_logic_vector(2 downto 0);
        instr_mode_i    : in     vl_logic_vector(3 downto 0);
        bl_mode_i       : in     vl_logic_vector(1 downto 0);
        data_mode_i     : in     vl_logic_vector(3 downto 0);
        mode_load_i     : in     vl_logic;
        fixed_bl_i      : in     vl_logic_vector(5 downto 0);
        fixed_instr_i   : in     vl_logic_vector(2 downto 0);
        fixed_addr_i    : in     vl_logic_vector(31 downto 0);
        fixed_data_i    : in     vl_logic_vector;
        bram_cmd_i      : in     vl_logic_vector(38 downto 0);
        bram_valid_i    : in     vl_logic;
        bram_rdy_o      : out    vl_logic;
        mcb_cmd_en_o    : out    vl_logic;
        mcb_cmd_instr_o : out    vl_logic_vector(2 downto 0);
        mcb_cmd_addr_o  : out    vl_logic_vector;
        mcb_cmd_bl_o    : out    vl_logic_vector(5 downto 0);
        mcb_cmd_full_i  : in     vl_logic;
        mcb_wr_en_o     : out    vl_logic;
        mcb_wr_data_o   : out    vl_logic_vector;
        mcb_wr_data_end_o: out    vl_logic;
        mcb_wr_mask_o   : out    vl_logic_vector;
        mcb_wr_full_i   : in     vl_logic;
        mcb_wr_fifo_counts: in     vl_logic_vector(6 downto 0);
        mcb_rd_en_o     : out    vl_logic;
        mcb_rd_data_i   : in     vl_logic_vector;
        mcb_rd_empty_i  : in     vl_logic;
        mcb_rd_fifo_counts: in     vl_logic_vector(6 downto 0);
        counts_rst      : in     vl_logic;
        wr_data_counts  : out    vl_logic_vector(47 downto 0);
        rd_data_counts  : out    vl_logic_vector(47 downto 0);
        cmp_error       : out    vl_logic;
        cmp_data_valid  : out    vl_logic;
        error           : out    vl_logic;
        error_status    : out    vl_logic_vector;
        cmp_data        : out    vl_logic_vector;
        mem_rd_data     : out    vl_logic_vector;
        dq_error_bytelane_cmp: out    vl_logic_vector;
        cumlative_dq_lane_error: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of SIMULATION : constant is 1;
    attribute mti_svvh_generic_type of MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of PORT_MODE : constant is 1;
    attribute mti_svvh_generic_type of DATA_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of CMD_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CMP_DATA_PIPE_STAGES : constant is 1;
    attribute mti_svvh_generic_type of MEM_COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of DQ_ERROR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SEL_VICTIM_LINE : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of PRBS_EADDR_MASK_POS : constant is 1;
    attribute mti_svvh_generic_type of PRBS_SADDR_MASK_POS : constant is 1;
    attribute mti_svvh_generic_type of PRBS_EADDR : constant is 1;
    attribute mti_svvh_generic_type of PRBS_SADDR : constant is 1;
    attribute mti_svvh_generic_type of EYE_TEST : constant is 1;
end mcb_traffic_gen;

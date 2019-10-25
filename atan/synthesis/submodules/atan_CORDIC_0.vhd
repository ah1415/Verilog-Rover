-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.0 (Release Build #614)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from atan_CORDIC_0
-- VHDL created on Wed Nov 14 00:22:48 2018


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity atan_CORDIC_0 is
    port (
        x : in std_logic_vector(11 downto 0);  -- ufix12
        y : in std_logic_vector(11 downto 0);  -- ufix12
        q : out std_logic_vector(8 downto 0);  -- sfix9_en7
        clk : in std_logic;
        areset : in std_logic
    );
end atan_CORDIC_0;

architecture normal of atan_CORDIC_0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yNotZero_uid6_atan2Test_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal yNotZero_uid6_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yZero_uid7_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid8_atan2Test_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid8_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xZero_uid9_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_0_uid13_atan2Test_q : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_1_uid14_atan2Test_a : STD_LOGIC_VECTOR (12 downto 0);
    signal xip1E_1_uid14_atan2Test_b : STD_LOGIC_VECTOR (12 downto 0);
    signal xip1E_1_uid14_atan2Test_o : STD_LOGIC_VECTOR (12 downto 0);
    signal xip1E_1_uid14_atan2Test_q : STD_LOGIC_VECTOR (12 downto 0);
    signal yip1E_1_uid15_atan2Test_a : STD_LOGIC_VECTOR (12 downto 0);
    signal yip1E_1_uid15_atan2Test_b : STD_LOGIC_VECTOR (12 downto 0);
    signal yip1E_1_uid15_atan2Test_o : STD_LOGIC_VECTOR (12 downto 0);
    signal yip1E_1_uid15_atan2Test_q : STD_LOGIC_VECTOR (12 downto 0);
    signal lowRangeB_uid16_atan2Test_in : STD_LOGIC_VECTOR (16 downto 0);
    signal lowRangeB_uid16_atan2Test_b : STD_LOGIC_VECTOR (16 downto 0);
    signal highBBits_uid17_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_1_uid19_atan2Test_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1_1_mergedSignalTM_uid22_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal xMSB_uid24_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1_1_mergedSignalTM_uid28_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal aip1E_uid30_atan2Test_in : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_uid30_atan2Test_b : STD_LOGIC_VECTOR (18 downto 0);
    signal xMSB_uid31_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_1_uid35_atan2Test_q : STD_LOGIC_VECTOR (18 downto 0);
    signal invSignOfSelectionSignal_uid36_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2NA_uid38_atan2Test_q : STD_LOGIC_VECTOR (14 downto 0);
    signal xip1E_2sumAHighB_uid39_atan2Test_a : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_2sumAHighB_uid39_atan2Test_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_2sumAHighB_uid39_atan2Test_o : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_2sumAHighB_uid39_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2sumAHighB_uid39_atan2Test_q : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_2NA_uid41_atan2Test_q : STD_LOGIC_VECTOR (14 downto 0);
    signal yip1E_2sumAHighB_uid42_atan2Test_a : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_2sumAHighB_uid42_atan2Test_b : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_2sumAHighB_uid42_atan2Test_o : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_2sumAHighB_uid42_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_2sumAHighB_uid42_atan2Test_q : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_2CostZeroPaddingA_uid44_atan2Test_q : STD_LOGIC_VECTOR (1 downto 0);
    signal aip1E_2NA_uid45_atan2Test_q : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_2sumAHighB_uid46_atan2Test_a : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_2sumAHighB_uid46_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_2sumAHighB_uid46_atan2Test_o : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_2sumAHighB_uid46_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_2sumAHighB_uid46_atan2Test_q : STD_LOGIC_VECTOR (21 downto 0);
    signal xip1_2_uid47_atan2Test_in : STD_LOGIC_VECTOR (14 downto 0);
    signal xip1_2_uid47_atan2Test_b : STD_LOGIC_VECTOR (14 downto 0);
    signal yip1_2_uid48_atan2Test_in : STD_LOGIC_VECTOR (14 downto 0);
    signal yip1_2_uid48_atan2Test_b : STD_LOGIC_VECTOR (14 downto 0);
    signal aip1E_uid49_atan2Test_in : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_uid49_atan2Test_b : STD_LOGIC_VECTOR (20 downto 0);
    signal xMSB_uid50_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_2_uid54_atan2Test_q : STD_LOGIC_VECTOR (19 downto 0);
    signal invSignOfSelectionSignal_uid55_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3NA_uid57_atan2Test_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1E_3sumAHighB_uid58_atan2Test_a : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_3sumAHighB_uid58_atan2Test_b : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_3sumAHighB_uid58_atan2Test_o : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_3sumAHighB_uid58_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3sumAHighB_uid58_atan2Test_q : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_3NA_uid60_atan2Test_q : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_3sumAHighB_uid61_atan2Test_a : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_3sumAHighB_uid61_atan2Test_b : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_3sumAHighB_uid61_atan2Test_o : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_3sumAHighB_uid61_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_3sumAHighB_uid61_atan2Test_q : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_3NA_uid64_atan2Test_q : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_3sumAHighB_uid65_atan2Test_a : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_3sumAHighB_uid65_atan2Test_b : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_3sumAHighB_uid65_atan2Test_o : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_3sumAHighB_uid65_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_3sumAHighB_uid65_atan2Test_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1_3_uid66_atan2Test_in : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1_3_uid66_atan2Test_b : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1_3_uid67_atan2Test_in : STD_LOGIC_VECTOR (15 downto 0);
    signal yip1_3_uid67_atan2Test_b : STD_LOGIC_VECTOR (15 downto 0);
    signal aip1E_uid68_atan2Test_in : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_uid68_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xMSB_uid69_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_3_uid73_atan2Test_q : STD_LOGIC_VECTOR (20 downto 0);
    signal invSignOfSelectionSignal_uid74_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4CostZeroPaddingA_uid75_atan2Test_q : STD_LOGIC_VECTOR (2 downto 0);
    signal xip1E_4NA_uid76_atan2Test_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_4sumAHighB_uid77_atan2Test_a : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_4sumAHighB_uid77_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_4sumAHighB_uid77_atan2Test_o : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_4sumAHighB_uid77_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4sumAHighB_uid77_atan2Test_q : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_4NA_uid79_atan2Test_q : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_4sumAHighB_uid80_atan2Test_a : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_4sumAHighB_uid80_atan2Test_b : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_4sumAHighB_uid80_atan2Test_o : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_4sumAHighB_uid80_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_4sumAHighB_uid80_atan2Test_q : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_4NA_uid83_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_4sumAHighB_uid84_atan2Test_a : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_4sumAHighB_uid84_atan2Test_b : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_4sumAHighB_uid84_atan2Test_o : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_4sumAHighB_uid84_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_4sumAHighB_uid84_atan2Test_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1_4_uid85_atan2Test_in : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1_4_uid85_atan2Test_b : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1_4_uid86_atan2Test_in : STD_LOGIC_VECTOR (17 downto 0);
    signal yip1_4_uid86_atan2Test_b : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_uid87_atan2Test_in : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_uid87_atan2Test_b : STD_LOGIC_VECTOR (24 downto 0);
    signal xMSB_uid88_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid92_atan2Test_b : STD_LOGIC_VECTOR (18 downto 0);
    signal twoToMiSiYip_uid93_atan2Test_b : STD_LOGIC_VECTOR (16 downto 0);
    signal cstArcTan2Mi_4_uid94_atan2Test_q : STD_LOGIC_VECTOR (21 downto 0);
    signal invSignOfSelectionSignal_uid95_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5NA_uid97_atan2Test_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_5sumAHighB_uid98_atan2Test_a : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_5sumAHighB_uid98_atan2Test_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_5sumAHighB_uid98_atan2Test_o : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_5sumAHighB_uid98_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5sumAHighB_uid98_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_5NA_uid100_atan2Test_q : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_5sumAHighB_uid101_atan2Test_a : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_5sumAHighB_uid101_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_5sumAHighB_uid101_atan2Test_o : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_5sumAHighB_uid101_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_5sumAHighB_uid101_atan2Test_q : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_5NA_uid104_atan2Test_q : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_5sumAHighB_uid105_atan2Test_a : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_5sumAHighB_uid105_atan2Test_b : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_5sumAHighB_uid105_atan2Test_o : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_5sumAHighB_uid105_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_5sumAHighB_uid105_atan2Test_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1_5_uid106_atan2Test_in : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_5_uid106_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1_5_uid107_atan2Test_in : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1_5_uid107_atan2Test_b : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_uid108_atan2Test_in : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_uid108_atan2Test_b : STD_LOGIC_VECTOR (26 downto 0);
    signal xMSB_uid109_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid113_atan2Test_b : STD_LOGIC_VECTOR (17 downto 0);
    signal twoToMiSiYip_uid114_atan2Test_b : STD_LOGIC_VECTOR (14 downto 0);
    signal cstArcTan2Mi_5_uid115_atan2Test_q : STD_LOGIC_VECTOR (22 downto 0);
    signal invSignOfSelectionSignal_uid116_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6_uid117_atan2Test_a : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_6_uid117_atan2Test_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_6_uid117_atan2Test_o : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_6_uid117_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6_uid117_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_6_uid118_atan2Test_a : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_6_uid118_atan2Test_b : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_6_uid118_atan2Test_o : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_6_uid118_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_6_uid118_atan2Test_q : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_6NA_uid121_atan2Test_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_6sumAHighB_uid122_atan2Test_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_6sumAHighB_uid122_atan2Test_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_6sumAHighB_uid122_atan2Test_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_6sumAHighB_uid122_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_6sumAHighB_uid122_atan2Test_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_6_uid123_atan2Test_in : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_6_uid123_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1_6_uid124_atan2Test_in : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1_6_uid124_atan2Test_b : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_uid125_atan2Test_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid125_atan2Test_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid126_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid130_atan2Test_b : STD_LOGIC_VECTOR (16 downto 0);
    signal twoToMiSiYip_uid131_atan2Test_b : STD_LOGIC_VECTOR (12 downto 0);
    signal cstArcTan2Mi_6_uid132_atan2Test_q : STD_LOGIC_VECTOR (23 downto 0);
    signal invSignOfSelectionSignal_uid133_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7_uid134_atan2Test_a : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_7_uid134_atan2Test_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_7_uid134_atan2Test_o : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_7_uid134_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7_uid134_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_7_uid135_atan2Test_a : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_7_uid135_atan2Test_b : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_7_uid135_atan2Test_o : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_7_uid135_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_7_uid135_atan2Test_q : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_7NA_uid138_atan2Test_q : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_7sumAHighB_uid139_atan2Test_a : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_7sumAHighB_uid139_atan2Test_b : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_7sumAHighB_uid139_atan2Test_o : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_7sumAHighB_uid139_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_7sumAHighB_uid139_atan2Test_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xip1_7_uid140_atan2Test_in : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_7_uid140_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1_7_uid141_atan2Test_in : STD_LOGIC_VECTOR (17 downto 0);
    signal yip1_7_uid141_atan2Test_b : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_uid142_atan2Test_in : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_uid142_atan2Test_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xMSB_uid143_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid147_atan2Test_b : STD_LOGIC_VECTOR (15 downto 0);
    signal cstArcTan2Mi_7_uid149_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_8_uid152_atan2Test_a : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_8_uid152_atan2Test_b : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_8_uid152_atan2Test_o : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_8_uid152_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_8_uid152_atan2Test_q : STD_LOGIC_VECTOR (18 downto 0);
    signal invSignOfSelectionSignal_uid153_atan2Test_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignOfSelectionSignal_uid153_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_8NA_uid155_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_8sumAHighB_uid156_atan2Test_a : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_8sumAHighB_uid156_atan2Test_b : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_8sumAHighB_uid156_atan2Test_o : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_8sumAHighB_uid156_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_8sumAHighB_uid156_atan2Test_q : STD_LOGIC_VECTOR (33 downto 0);
    signal yip1_8_uid158_atan2Test_in : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1_8_uid158_atan2Test_b : STD_LOGIC_VECTOR (16 downto 0);
    signal aip1E_uid159_atan2Test_in : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_uid159_atan2Test_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xMSB_uid160_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_8_uid166_atan2Test_q : STD_LOGIC_VECTOR (25 downto 0);
    signal invSignOfSelectionSignal_uid170_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_9NA_uid172_atan2Test_q : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_9sumAHighB_uid173_atan2Test_a : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_9sumAHighB_uid173_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_9sumAHighB_uid173_atan2Test_o : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_9sumAHighB_uid173_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_9sumAHighB_uid173_atan2Test_q : STD_LOGIC_VECTOR (35 downto 0);
    signal aip1E_uid176_atan2Test_in : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_uid176_atan2Test_b : STD_LOGIC_VECTOR (34 downto 0);
    signal alphaPreRnd_uid177_atan2Test_b : STD_LOGIC_VECTOR (9 downto 0);
    signal alphaPostRnd_uid180_atan2Test_a : STD_LOGIC_VECTOR (10 downto 0);
    signal alphaPostRnd_uid180_atan2Test_b : STD_LOGIC_VECTOR (10 downto 0);
    signal alphaPostRnd_uid180_atan2Test_o : STD_LOGIC_VECTOR (10 downto 0);
    signal alphaPostRnd_uid180_atan2Test_q : STD_LOGIC_VECTOR (10 downto 0);
    signal atanRes_uid181_atan2Test_in : STD_LOGIC_VECTOR (9 downto 0);
    signal atanRes_uid181_atan2Test_b : STD_LOGIC_VECTOR (8 downto 0);
    signal cstZeroOutFormat_uid182_atan2Test_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cstPiO2OutFormatL_uid183_atan2Test_q : STD_LOGIC_VECTOR (6 downto 0);
    signal cstPiO2OutFormat_mergedSignalTMB_uid186_atan2Test_q : STD_LOGIC_VECTOR (8 downto 0);
    signal concXZeroYZero_uid188_atan2Test_q : STD_LOGIC_VECTOR (1 downto 0);
    signal atanResPostExc_uid189_atan2Test_s : STD_LOGIC_VECTOR (1 downto 0);
    signal atanResPostExc_uid189_atan2Test_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist0_xMSB_uid160_atan2Test_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_invSignOfSelectionSignal_uid133_atan2Test_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_invSignOfSelectionSignal_uid116_atan2Test_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_aip1E_uid108_atan2Test_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist4_yip1_3_uid67_atan2Test_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist5_xip1_3_uid66_atan2Test_b_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist6_invSignOfSelectionSignal_uid55_atan2Test_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_invSignOfSelectionSignal_uid36_atan2Test_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_xNotZero_uid8_atan2Test_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_yNotZero_uid6_atan2Test_q_2_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cstPiO2OutFormatL_uid183_atan2Test(CONSTANT,182)
    cstPiO2OutFormatL_uid183_atan2Test_q <= "1100101";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- cstPiO2OutFormat_mergedSignalTMB_uid186_atan2Test(BITJOIN,185)@2
    cstPiO2OutFormat_mergedSignalTMB_uid186_atan2Test_q <= GND_q & cstPiO2OutFormatL_uid183_atan2Test_q & GND_q;

    -- cstZeroOutFormat_uid182_atan2Test(CONSTANT,181)
    cstZeroOutFormat_uid182_atan2Test_q <= "000000000";

    -- xMSB_uid143_atan2Test(BITSELECT,142)@1
    xMSB_uid143_atan2Test_b <= STD_LOGIC_VECTOR(yip1_7_uid141_atan2Test_b(17 downto 17));

    -- xMSB_uid109_atan2Test(BITSELECT,108)@1
    xMSB_uid109_atan2Test_b <= STD_LOGIC_VECTOR(yip1_5_uid107_atan2Test_b(19 downto 19));

    -- xMSB_uid24_atan2Test(BITSELECT,23)@0
    xMSB_uid24_atan2Test_b <= STD_LOGIC_VECTOR(yip1E_1_uid15_atan2Test_q(12 downto 12));

    -- yip1E_1_uid15_atan2Test(SUB,14)@0
    yip1E_1_uid15_atan2Test_a <= STD_LOGIC_VECTOR("0" & y);
    yip1E_1_uid15_atan2Test_b <= STD_LOGIC_VECTOR("0" & x);
    yip1E_1_uid15_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(yip1E_1_uid15_atan2Test_a) - UNSIGNED(yip1E_1_uid15_atan2Test_b));
    yip1E_1_uid15_atan2Test_q <= yip1E_1_uid15_atan2Test_o(12 downto 0);

    -- yip1_1_mergedSignalTM_uid28_atan2Test(BITJOIN,27)@0
    yip1_1_mergedSignalTM_uid28_atan2Test_q <= xMSB_uid24_atan2Test_b & yip1E_1_uid15_atan2Test_q;

    -- xMSB_uid31_atan2Test(BITSELECT,30)@0
    xMSB_uid31_atan2Test_b <= STD_LOGIC_VECTOR(yip1_1_mergedSignalTM_uid28_atan2Test_q(13 downto 13));

    -- xip1E_1_uid14_atan2Test(ADD,13)@0
    xip1E_1_uid14_atan2Test_a <= STD_LOGIC_VECTOR("0" & x);
    xip1E_1_uid14_atan2Test_b <= STD_LOGIC_VECTOR("0" & y);
    xip1E_1_uid14_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(xip1E_1_uid14_atan2Test_a) + UNSIGNED(xip1E_1_uid14_atan2Test_b));
    xip1E_1_uid14_atan2Test_q <= xip1E_1_uid14_atan2Test_o(12 downto 0);

    -- xip1_1_mergedSignalTM_uid22_atan2Test(BITJOIN,21)@0
    xip1_1_mergedSignalTM_uid22_atan2Test_q <= GND_q & xip1E_1_uid14_atan2Test_q;

    -- yip1E_2NA_uid41_atan2Test(BITJOIN,40)@0
    yip1E_2NA_uid41_atan2Test_q <= yip1_1_mergedSignalTM_uid28_atan2Test_q & GND_q;

    -- yip1E_2sumAHighB_uid42_atan2Test(ADDSUB,41)@0
    yip1E_2sumAHighB_uid42_atan2Test_s <= xMSB_uid31_atan2Test_b;
    yip1E_2sumAHighB_uid42_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 15 => yip1E_2NA_uid41_atan2Test_q(14)) & yip1E_2NA_uid41_atan2Test_q));
    yip1E_2sumAHighB_uid42_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1_1_mergedSignalTM_uid22_atan2Test_q));
    yip1E_2sumAHighB_uid42_atan2Test_combproc: PROCESS (yip1E_2sumAHighB_uid42_atan2Test_a, yip1E_2sumAHighB_uid42_atan2Test_b, yip1E_2sumAHighB_uid42_atan2Test_s)
    BEGIN
        IF (yip1E_2sumAHighB_uid42_atan2Test_s = "1") THEN
            yip1E_2sumAHighB_uid42_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid42_atan2Test_a) + SIGNED(yip1E_2sumAHighB_uid42_atan2Test_b));
        ELSE
            yip1E_2sumAHighB_uid42_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid42_atan2Test_a) - SIGNED(yip1E_2sumAHighB_uid42_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_2sumAHighB_uid42_atan2Test_q <= yip1E_2sumAHighB_uid42_atan2Test_o(15 downto 0);

    -- yip1_2_uid48_atan2Test(BITSELECT,47)@0
    yip1_2_uid48_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_2sumAHighB_uid42_atan2Test_q(14 downto 0));
    yip1_2_uid48_atan2Test_b <= STD_LOGIC_VECTOR(yip1_2_uid48_atan2Test_in(14 downto 0));

    -- xMSB_uid50_atan2Test(BITSELECT,49)@0
    xMSB_uid50_atan2Test_b <= STD_LOGIC_VECTOR(yip1_2_uid48_atan2Test_b(14 downto 14));

    -- invSignOfSelectionSignal_uid36_atan2Test(LOGICAL,35)@0
    invSignOfSelectionSignal_uid36_atan2Test_q <= not (xMSB_uid31_atan2Test_b);

    -- xip1E_2NA_uid38_atan2Test(BITJOIN,37)@0
    xip1E_2NA_uid38_atan2Test_q <= xip1_1_mergedSignalTM_uid22_atan2Test_q & GND_q;

    -- xip1E_2sumAHighB_uid39_atan2Test(ADDSUB,38)@0
    xip1E_2sumAHighB_uid39_atan2Test_s <= invSignOfSelectionSignal_uid36_atan2Test_q;
    xip1E_2sumAHighB_uid39_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_2NA_uid38_atan2Test_q));
    xip1E_2sumAHighB_uid39_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 14 => yip1_1_mergedSignalTM_uid28_atan2Test_q(13)) & yip1_1_mergedSignalTM_uid28_atan2Test_q));
    xip1E_2sumAHighB_uid39_atan2Test_combproc: PROCESS (xip1E_2sumAHighB_uid39_atan2Test_a, xip1E_2sumAHighB_uid39_atan2Test_b, xip1E_2sumAHighB_uid39_atan2Test_s)
    BEGIN
        IF (xip1E_2sumAHighB_uid39_atan2Test_s = "1") THEN
            xip1E_2sumAHighB_uid39_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid39_atan2Test_a) + SIGNED(xip1E_2sumAHighB_uid39_atan2Test_b));
        ELSE
            xip1E_2sumAHighB_uid39_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid39_atan2Test_a) - SIGNED(xip1E_2sumAHighB_uid39_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_2sumAHighB_uid39_atan2Test_q <= xip1E_2sumAHighB_uid39_atan2Test_o(16 downto 0);

    -- xip1_2_uid47_atan2Test(BITSELECT,46)@0
    xip1_2_uid47_atan2Test_in <= xip1E_2sumAHighB_uid39_atan2Test_q(14 downto 0);
    xip1_2_uid47_atan2Test_b <= xip1_2_uid47_atan2Test_in(14 downto 0);

    -- aip1E_2CostZeroPaddingA_uid44_atan2Test(CONSTANT,43)
    aip1E_2CostZeroPaddingA_uid44_atan2Test_q <= "00";

    -- yip1E_3NA_uid60_atan2Test(BITJOIN,59)@0
    yip1E_3NA_uid60_atan2Test_q <= yip1_2_uid48_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- yip1E_3sumAHighB_uid61_atan2Test(ADDSUB,60)@0
    yip1E_3sumAHighB_uid61_atan2Test_s <= xMSB_uid50_atan2Test_b;
    yip1E_3sumAHighB_uid61_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => yip1E_3NA_uid60_atan2Test_q(16)) & yip1E_3NA_uid60_atan2Test_q));
    yip1E_3sumAHighB_uid61_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & xip1_2_uid47_atan2Test_b));
    yip1E_3sumAHighB_uid61_atan2Test_combproc: PROCESS (yip1E_3sumAHighB_uid61_atan2Test_a, yip1E_3sumAHighB_uid61_atan2Test_b, yip1E_3sumAHighB_uid61_atan2Test_s)
    BEGIN
        IF (yip1E_3sumAHighB_uid61_atan2Test_s = "1") THEN
            yip1E_3sumAHighB_uid61_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid61_atan2Test_a) + SIGNED(yip1E_3sumAHighB_uid61_atan2Test_b));
        ELSE
            yip1E_3sumAHighB_uid61_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid61_atan2Test_a) - SIGNED(yip1E_3sumAHighB_uid61_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_3sumAHighB_uid61_atan2Test_q <= yip1E_3sumAHighB_uid61_atan2Test_o(17 downto 0);

    -- yip1_3_uid67_atan2Test(BITSELECT,66)@0
    yip1_3_uid67_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_3sumAHighB_uid61_atan2Test_q(15 downto 0));
    yip1_3_uid67_atan2Test_b <= STD_LOGIC_VECTOR(yip1_3_uid67_atan2Test_in(15 downto 0));

    -- redist4_yip1_3_uid67_atan2Test_b_1(DELAY,194)
    redist4_yip1_3_uid67_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_3_uid67_atan2Test_b, xout => redist4_yip1_3_uid67_atan2Test_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid69_atan2Test(BITSELECT,68)@1
    xMSB_uid69_atan2Test_b <= STD_LOGIC_VECTOR(redist4_yip1_3_uid67_atan2Test_b_1_q(15 downto 15));

    -- invSignOfSelectionSignal_uid55_atan2Test(LOGICAL,54)@0
    invSignOfSelectionSignal_uid55_atan2Test_q <= not (xMSB_uid50_atan2Test_b);

    -- xip1E_3NA_uid57_atan2Test(BITJOIN,56)@0
    xip1E_3NA_uid57_atan2Test_q <= xip1_2_uid47_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- xip1E_3sumAHighB_uid58_atan2Test(ADDSUB,57)@0
    xip1E_3sumAHighB_uid58_atan2Test_s <= invSignOfSelectionSignal_uid55_atan2Test_q;
    xip1E_3sumAHighB_uid58_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_3NA_uid57_atan2Test_q));
    xip1E_3sumAHighB_uid58_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 15 => yip1_2_uid48_atan2Test_b(14)) & yip1_2_uid48_atan2Test_b));
    xip1E_3sumAHighB_uid58_atan2Test_combproc: PROCESS (xip1E_3sumAHighB_uid58_atan2Test_a, xip1E_3sumAHighB_uid58_atan2Test_b, xip1E_3sumAHighB_uid58_atan2Test_s)
    BEGIN
        IF (xip1E_3sumAHighB_uid58_atan2Test_s = "1") THEN
            xip1E_3sumAHighB_uid58_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid58_atan2Test_a) + SIGNED(xip1E_3sumAHighB_uid58_atan2Test_b));
        ELSE
            xip1E_3sumAHighB_uid58_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid58_atan2Test_a) - SIGNED(xip1E_3sumAHighB_uid58_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_3sumAHighB_uid58_atan2Test_q <= xip1E_3sumAHighB_uid58_atan2Test_o(18 downto 0);

    -- xip1_3_uid66_atan2Test(BITSELECT,65)@0
    xip1_3_uid66_atan2Test_in <= xip1E_3sumAHighB_uid58_atan2Test_q(16 downto 0);
    xip1_3_uid66_atan2Test_b <= xip1_3_uid66_atan2Test_in(16 downto 0);

    -- redist5_xip1_3_uid66_atan2Test_b_1(DELAY,195)
    redist5_xip1_3_uid66_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_3_uid66_atan2Test_b, xout => redist5_xip1_3_uid66_atan2Test_b_1_q, clk => clk, aclr => areset );

    -- xip1E_4CostZeroPaddingA_uid75_atan2Test(CONSTANT,74)
    xip1E_4CostZeroPaddingA_uid75_atan2Test_q <= "000";

    -- yip1E_4NA_uid79_atan2Test(BITJOIN,78)@1
    yip1E_4NA_uid79_atan2Test_q <= redist4_yip1_3_uid67_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid75_atan2Test_q;

    -- yip1E_4sumAHighB_uid80_atan2Test(ADDSUB,79)@1
    yip1E_4sumAHighB_uid80_atan2Test_s <= xMSB_uid69_atan2Test_b;
    yip1E_4sumAHighB_uid80_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 19 => yip1E_4NA_uid79_atan2Test_q(18)) & yip1E_4NA_uid79_atan2Test_q));
    yip1E_4sumAHighB_uid80_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist5_xip1_3_uid66_atan2Test_b_1_q));
    yip1E_4sumAHighB_uid80_atan2Test_combproc: PROCESS (yip1E_4sumAHighB_uid80_atan2Test_a, yip1E_4sumAHighB_uid80_atan2Test_b, yip1E_4sumAHighB_uid80_atan2Test_s)
    BEGIN
        IF (yip1E_4sumAHighB_uid80_atan2Test_s = "1") THEN
            yip1E_4sumAHighB_uid80_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid80_atan2Test_a) + SIGNED(yip1E_4sumAHighB_uid80_atan2Test_b));
        ELSE
            yip1E_4sumAHighB_uid80_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid80_atan2Test_a) - SIGNED(yip1E_4sumAHighB_uid80_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_4sumAHighB_uid80_atan2Test_q <= yip1E_4sumAHighB_uid80_atan2Test_o(19 downto 0);

    -- yip1_4_uid86_atan2Test(BITSELECT,85)@1
    yip1_4_uid86_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_4sumAHighB_uid80_atan2Test_q(17 downto 0));
    yip1_4_uid86_atan2Test_b <= STD_LOGIC_VECTOR(yip1_4_uid86_atan2Test_in(17 downto 0));

    -- xMSB_uid88_atan2Test(BITSELECT,87)@1
    xMSB_uid88_atan2Test_b <= STD_LOGIC_VECTOR(yip1_4_uid86_atan2Test_b(17 downto 17));

    -- invSignOfSelectionSignal_uid95_atan2Test(LOGICAL,94)@1
    invSignOfSelectionSignal_uid95_atan2Test_q <= not (xMSB_uid88_atan2Test_b);

    -- twoToMiSiYip_uid93_atan2Test(BITSELECT,92)@1
    twoToMiSiYip_uid93_atan2Test_b <= STD_LOGIC_VECTOR(yip1_4_uid86_atan2Test_b(17 downto 1));

    -- invSignOfSelectionSignal_uid74_atan2Test(LOGICAL,73)@1
    invSignOfSelectionSignal_uid74_atan2Test_q <= not (xMSB_uid69_atan2Test_b);

    -- xip1E_4NA_uid76_atan2Test(BITJOIN,75)@1
    xip1E_4NA_uid76_atan2Test_q <= redist5_xip1_3_uid66_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid75_atan2Test_q;

    -- xip1E_4sumAHighB_uid77_atan2Test(ADDSUB,76)@1
    xip1E_4sumAHighB_uid77_atan2Test_s <= invSignOfSelectionSignal_uid74_atan2Test_q;
    xip1E_4sumAHighB_uid77_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_4NA_uid76_atan2Test_q));
    xip1E_4sumAHighB_uid77_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 16 => redist4_yip1_3_uid67_atan2Test_b_1_q(15)) & redist4_yip1_3_uid67_atan2Test_b_1_q));
    xip1E_4sumAHighB_uid77_atan2Test_combproc: PROCESS (xip1E_4sumAHighB_uid77_atan2Test_a, xip1E_4sumAHighB_uid77_atan2Test_b, xip1E_4sumAHighB_uid77_atan2Test_s)
    BEGIN
        IF (xip1E_4sumAHighB_uid77_atan2Test_s = "1") THEN
            xip1E_4sumAHighB_uid77_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid77_atan2Test_a) + SIGNED(xip1E_4sumAHighB_uid77_atan2Test_b));
        ELSE
            xip1E_4sumAHighB_uid77_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid77_atan2Test_a) - SIGNED(xip1E_4sumAHighB_uid77_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_4sumAHighB_uid77_atan2Test_q <= xip1E_4sumAHighB_uid77_atan2Test_o(21 downto 0);

    -- xip1_4_uid85_atan2Test(BITSELECT,84)@1
    xip1_4_uid85_atan2Test_in <= xip1E_4sumAHighB_uid77_atan2Test_q(19 downto 0);
    xip1_4_uid85_atan2Test_b <= xip1_4_uid85_atan2Test_in(19 downto 0);

    -- xip1E_5NA_uid97_atan2Test(BITJOIN,96)@1
    xip1E_5NA_uid97_atan2Test_q <= xip1_4_uid85_atan2Test_b & xip1E_4CostZeroPaddingA_uid75_atan2Test_q;

    -- xip1E_5sumAHighB_uid98_atan2Test(ADDSUB,97)@1
    xip1E_5sumAHighB_uid98_atan2Test_s <= invSignOfSelectionSignal_uid95_atan2Test_q;
    xip1E_5sumAHighB_uid98_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_5NA_uid97_atan2Test_q));
    xip1E_5sumAHighB_uid98_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 17 => twoToMiSiYip_uid93_atan2Test_b(16)) & twoToMiSiYip_uid93_atan2Test_b));
    xip1E_5sumAHighB_uid98_atan2Test_combproc: PROCESS (xip1E_5sumAHighB_uid98_atan2Test_a, xip1E_5sumAHighB_uid98_atan2Test_b, xip1E_5sumAHighB_uid98_atan2Test_s)
    BEGIN
        IF (xip1E_5sumAHighB_uid98_atan2Test_s = "1") THEN
            xip1E_5sumAHighB_uid98_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid98_atan2Test_a) + SIGNED(xip1E_5sumAHighB_uid98_atan2Test_b));
        ELSE
            xip1E_5sumAHighB_uid98_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid98_atan2Test_a) - SIGNED(xip1E_5sumAHighB_uid98_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_5sumAHighB_uid98_atan2Test_q <= xip1E_5sumAHighB_uid98_atan2Test_o(24 downto 0);

    -- xip1_5_uid106_atan2Test(BITSELECT,105)@1
    xip1_5_uid106_atan2Test_in <= xip1E_5sumAHighB_uid98_atan2Test_q(22 downto 0);
    xip1_5_uid106_atan2Test_b <= xip1_5_uid106_atan2Test_in(22 downto 0);

    -- twoToMiSiXip_uid113_atan2Test(BITSELECT,112)@1
    twoToMiSiXip_uid113_atan2Test_b <= xip1_5_uid106_atan2Test_b(22 downto 5);

    -- twoToMiSiXip_uid92_atan2Test(BITSELECT,91)@1
    twoToMiSiXip_uid92_atan2Test_b <= xip1_4_uid85_atan2Test_b(19 downto 1);

    -- yip1E_5NA_uid100_atan2Test(BITJOIN,99)@1
    yip1E_5NA_uid100_atan2Test_q <= yip1_4_uid86_atan2Test_b & xip1E_4CostZeroPaddingA_uid75_atan2Test_q;

    -- yip1E_5sumAHighB_uid101_atan2Test(ADDSUB,100)@1
    yip1E_5sumAHighB_uid101_atan2Test_s <= xMSB_uid88_atan2Test_b;
    yip1E_5sumAHighB_uid101_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => yip1E_5NA_uid100_atan2Test_q(20)) & yip1E_5NA_uid100_atan2Test_q));
    yip1E_5sumAHighB_uid101_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid92_atan2Test_b));
    yip1E_5sumAHighB_uid101_atan2Test_combproc: PROCESS (yip1E_5sumAHighB_uid101_atan2Test_a, yip1E_5sumAHighB_uid101_atan2Test_b, yip1E_5sumAHighB_uid101_atan2Test_s)
    BEGIN
        IF (yip1E_5sumAHighB_uid101_atan2Test_s = "1") THEN
            yip1E_5sumAHighB_uid101_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid101_atan2Test_a) + SIGNED(yip1E_5sumAHighB_uid101_atan2Test_b));
        ELSE
            yip1E_5sumAHighB_uid101_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid101_atan2Test_a) - SIGNED(yip1E_5sumAHighB_uid101_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_5sumAHighB_uid101_atan2Test_q <= yip1E_5sumAHighB_uid101_atan2Test_o(21 downto 0);

    -- yip1_5_uid107_atan2Test(BITSELECT,106)@1
    yip1_5_uid107_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_5sumAHighB_uid101_atan2Test_q(19 downto 0));
    yip1_5_uid107_atan2Test_b <= STD_LOGIC_VECTOR(yip1_5_uid107_atan2Test_in(19 downto 0));

    -- yip1E_6_uid118_atan2Test(ADDSUB,117)@1
    yip1E_6_uid118_atan2Test_s <= xMSB_uid109_atan2Test_b;
    yip1E_6_uid118_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 20 => yip1_5_uid107_atan2Test_b(19)) & yip1_5_uid107_atan2Test_b));
    yip1E_6_uid118_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid113_atan2Test_b));
    yip1E_6_uid118_atan2Test_combproc: PROCESS (yip1E_6_uid118_atan2Test_a, yip1E_6_uid118_atan2Test_b, yip1E_6_uid118_atan2Test_s)
    BEGIN
        IF (yip1E_6_uid118_atan2Test_s = "1") THEN
            yip1E_6_uid118_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6_uid118_atan2Test_a) + SIGNED(yip1E_6_uid118_atan2Test_b));
        ELSE
            yip1E_6_uid118_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6_uid118_atan2Test_a) - SIGNED(yip1E_6_uid118_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_6_uid118_atan2Test_q <= yip1E_6_uid118_atan2Test_o(20 downto 0);

    -- yip1_6_uid124_atan2Test(BITSELECT,123)@1
    yip1_6_uid124_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_6_uid118_atan2Test_q(18 downto 0));
    yip1_6_uid124_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid124_atan2Test_in(18 downto 0));

    -- xMSB_uid126_atan2Test(BITSELECT,125)@1
    xMSB_uid126_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid124_atan2Test_b(18 downto 18));

    -- invSignOfSelectionSignal_uid133_atan2Test(LOGICAL,132)@1
    invSignOfSelectionSignal_uid133_atan2Test_q <= not (xMSB_uid126_atan2Test_b);

    -- twoToMiSiYip_uid131_atan2Test(BITSELECT,130)@1
    twoToMiSiYip_uid131_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid124_atan2Test_b(18 downto 6));

    -- invSignOfSelectionSignal_uid116_atan2Test(LOGICAL,115)@1
    invSignOfSelectionSignal_uid116_atan2Test_q <= not (xMSB_uid109_atan2Test_b);

    -- twoToMiSiYip_uid114_atan2Test(BITSELECT,113)@1
    twoToMiSiYip_uid114_atan2Test_b <= STD_LOGIC_VECTOR(yip1_5_uid107_atan2Test_b(19 downto 5));

    -- xip1E_6_uid117_atan2Test(ADDSUB,116)@1
    xip1E_6_uid117_atan2Test_s <= invSignOfSelectionSignal_uid116_atan2Test_q;
    xip1E_6_uid117_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1_5_uid106_atan2Test_b));
    xip1E_6_uid117_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 15 => twoToMiSiYip_uid114_atan2Test_b(14)) & twoToMiSiYip_uid114_atan2Test_b));
    xip1E_6_uid117_atan2Test_combproc: PROCESS (xip1E_6_uid117_atan2Test_a, xip1E_6_uid117_atan2Test_b, xip1E_6_uid117_atan2Test_s)
    BEGIN
        IF (xip1E_6_uid117_atan2Test_s = "1") THEN
            xip1E_6_uid117_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6_uid117_atan2Test_a) + SIGNED(xip1E_6_uid117_atan2Test_b));
        ELSE
            xip1E_6_uid117_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6_uid117_atan2Test_a) - SIGNED(xip1E_6_uid117_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_6_uid117_atan2Test_q <= xip1E_6_uid117_atan2Test_o(24 downto 0);

    -- xip1_6_uid123_atan2Test(BITSELECT,122)@1
    xip1_6_uid123_atan2Test_in <= xip1E_6_uid117_atan2Test_q(22 downto 0);
    xip1_6_uid123_atan2Test_b <= xip1_6_uid123_atan2Test_in(22 downto 0);

    -- xip1E_7_uid134_atan2Test(ADDSUB,133)@1
    xip1E_7_uid134_atan2Test_s <= invSignOfSelectionSignal_uid133_atan2Test_q;
    xip1E_7_uid134_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1_6_uid123_atan2Test_b));
    xip1E_7_uid134_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 13 => twoToMiSiYip_uid131_atan2Test_b(12)) & twoToMiSiYip_uid131_atan2Test_b));
    xip1E_7_uid134_atan2Test_combproc: PROCESS (xip1E_7_uid134_atan2Test_a, xip1E_7_uid134_atan2Test_b, xip1E_7_uid134_atan2Test_s)
    BEGIN
        IF (xip1E_7_uid134_atan2Test_s = "1") THEN
            xip1E_7_uid134_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7_uid134_atan2Test_a) + SIGNED(xip1E_7_uid134_atan2Test_b));
        ELSE
            xip1E_7_uid134_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7_uid134_atan2Test_a) - SIGNED(xip1E_7_uid134_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_7_uid134_atan2Test_q <= xip1E_7_uid134_atan2Test_o(24 downto 0);

    -- xip1_7_uid140_atan2Test(BITSELECT,139)@1
    xip1_7_uid140_atan2Test_in <= xip1E_7_uid134_atan2Test_q(22 downto 0);
    xip1_7_uid140_atan2Test_b <= xip1_7_uid140_atan2Test_in(22 downto 0);

    -- twoToMiSiXip_uid147_atan2Test(BITSELECT,146)@1
    twoToMiSiXip_uid147_atan2Test_b <= xip1_7_uid140_atan2Test_b(22 downto 7);

    -- twoToMiSiXip_uid130_atan2Test(BITSELECT,129)@1
    twoToMiSiXip_uid130_atan2Test_b <= xip1_6_uid123_atan2Test_b(22 downto 6);

    -- yip1E_7_uid135_atan2Test(ADDSUB,134)@1
    yip1E_7_uid135_atan2Test_s <= xMSB_uid126_atan2Test_b;
    yip1E_7_uid135_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 19 => yip1_6_uid124_atan2Test_b(18)) & yip1_6_uid124_atan2Test_b));
    yip1E_7_uid135_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid130_atan2Test_b));
    yip1E_7_uid135_atan2Test_combproc: PROCESS (yip1E_7_uid135_atan2Test_a, yip1E_7_uid135_atan2Test_b, yip1E_7_uid135_atan2Test_s)
    BEGIN
        IF (yip1E_7_uid135_atan2Test_s = "1") THEN
            yip1E_7_uid135_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7_uid135_atan2Test_a) + SIGNED(yip1E_7_uid135_atan2Test_b));
        ELSE
            yip1E_7_uid135_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7_uid135_atan2Test_a) - SIGNED(yip1E_7_uid135_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_7_uid135_atan2Test_q <= yip1E_7_uid135_atan2Test_o(19 downto 0);

    -- yip1_7_uid141_atan2Test(BITSELECT,140)@1
    yip1_7_uid141_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_7_uid135_atan2Test_q(17 downto 0));
    yip1_7_uid141_atan2Test_b <= STD_LOGIC_VECTOR(yip1_7_uid141_atan2Test_in(17 downto 0));

    -- yip1E_8_uid152_atan2Test(ADDSUB,151)@1
    yip1E_8_uid152_atan2Test_s <= xMSB_uid143_atan2Test_b;
    yip1E_8_uid152_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => yip1_7_uid141_atan2Test_b(17)) & yip1_7_uid141_atan2Test_b));
    yip1E_8_uid152_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid147_atan2Test_b));
    yip1E_8_uid152_atan2Test_combproc: PROCESS (yip1E_8_uid152_atan2Test_a, yip1E_8_uid152_atan2Test_b, yip1E_8_uid152_atan2Test_s)
    BEGIN
        IF (yip1E_8_uid152_atan2Test_s = "1") THEN
            yip1E_8_uid152_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid152_atan2Test_a) + SIGNED(yip1E_8_uid152_atan2Test_b));
        ELSE
            yip1E_8_uid152_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid152_atan2Test_a) - SIGNED(yip1E_8_uid152_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_8_uid152_atan2Test_q <= yip1E_8_uid152_atan2Test_o(18 downto 0);

    -- yip1_8_uid158_atan2Test(BITSELECT,157)@1
    yip1_8_uid158_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_8_uid152_atan2Test_q(16 downto 0));
    yip1_8_uid158_atan2Test_b <= STD_LOGIC_VECTOR(yip1_8_uid158_atan2Test_in(16 downto 0));

    -- xMSB_uid160_atan2Test(BITSELECT,159)@1
    xMSB_uid160_atan2Test_b <= STD_LOGIC_VECTOR(yip1_8_uid158_atan2Test_b(16 downto 16));

    -- redist0_xMSB_uid160_atan2Test_b_1(DELAY,190)
    redist0_xMSB_uid160_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid160_atan2Test_b, xout => redist0_xMSB_uid160_atan2Test_b_1_q, clk => clk, aclr => areset );

    -- invSignOfSelectionSignal_uid170_atan2Test(LOGICAL,169)@2
    invSignOfSelectionSignal_uid170_atan2Test_q <= not (redist0_xMSB_uid160_atan2Test_b_1_q);

    -- cstArcTan2Mi_8_uid166_atan2Test(CONSTANT,165)
    cstArcTan2Mi_8_uid166_atan2Test_q <= "01111111111111111101010101";

    -- invSignOfSelectionSignal_uid153_atan2Test(LOGICAL,152)@1 + 1
    invSignOfSelectionSignal_uid153_atan2Test_qi <= not (xMSB_uid143_atan2Test_b);
    invSignOfSelectionSignal_uid153_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invSignOfSelectionSignal_uid153_atan2Test_qi, xout => invSignOfSelectionSignal_uid153_atan2Test_q, clk => clk, aclr => areset );

    -- cstArcTan2Mi_7_uid149_atan2Test(CONSTANT,148)
    cstArcTan2Mi_7_uid149_atan2Test_q <= "0111111111111111010101011";

    -- redist1_invSignOfSelectionSignal_uid133_atan2Test_q_1(DELAY,191)
    redist1_invSignOfSelectionSignal_uid133_atan2Test_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invSignOfSelectionSignal_uid133_atan2Test_q, xout => redist1_invSignOfSelectionSignal_uid133_atan2Test_q_1_q, clk => clk, aclr => areset );

    -- cstArcTan2Mi_6_uid132_atan2Test(CONSTANT,131)
    cstArcTan2Mi_6_uid132_atan2Test_q <= "011111111111110101010101";

    -- redist2_invSignOfSelectionSignal_uid116_atan2Test_q_1(DELAY,192)
    redist2_invSignOfSelectionSignal_uid116_atan2Test_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invSignOfSelectionSignal_uid116_atan2Test_q, xout => redist2_invSignOfSelectionSignal_uid116_atan2Test_q_1_q, clk => clk, aclr => areset );

    -- cstArcTan2Mi_5_uid115_atan2Test(CONSTANT,114)
    cstArcTan2Mi_5_uid115_atan2Test_q <= "01111111111101010101011";

    -- cstArcTan2Mi_4_uid94_atan2Test(CONSTANT,93)
    cstArcTan2Mi_4_uid94_atan2Test_q <= "0111111111010101011100";

    -- cstArcTan2Mi_3_uid73_atan2Test(CONSTANT,72)
    cstArcTan2Mi_3_uid73_atan2Test_q <= "011111110101011011101";

    -- redist6_invSignOfSelectionSignal_uid55_atan2Test_q_1(DELAY,196)
    redist6_invSignOfSelectionSignal_uid55_atan2Test_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invSignOfSelectionSignal_uid55_atan2Test_q, xout => redist6_invSignOfSelectionSignal_uid55_atan2Test_q_1_q, clk => clk, aclr => areset );

    -- cstArcTan2Mi_2_uid54_atan2Test(CONSTANT,53)
    cstArcTan2Mi_2_uid54_atan2Test_q <= "01111101011011011101";

    -- redist7_invSignOfSelectionSignal_uid36_atan2Test_q_1(DELAY,197)
    redist7_invSignOfSelectionSignal_uid36_atan2Test_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invSignOfSelectionSignal_uid36_atan2Test_q, xout => redist7_invSignOfSelectionSignal_uid36_atan2Test_q_1_q, clk => clk, aclr => areset );

    -- cstArcTan2Mi_1_uid35_atan2Test(CONSTANT,34)
    cstArcTan2Mi_1_uid35_atan2Test_q <= "0111011010110001101";

    -- cstArcTan2Mi_0_uid13_atan2Test(CONSTANT,12)
    cstArcTan2Mi_0_uid13_atan2Test_q <= "011001001000100000";

    -- highBBits_uid17_atan2Test(BITSELECT,16)@1
    highBBits_uid17_atan2Test_b <= STD_LOGIC_VECTOR(cstArcTan2Mi_0_uid13_atan2Test_q(17 downto 17));

    -- lowRangeB_uid16_atan2Test(BITSELECT,15)@1
    lowRangeB_uid16_atan2Test_in <= cstArcTan2Mi_0_uid13_atan2Test_q(16 downto 0);
    lowRangeB_uid16_atan2Test_b <= lowRangeB_uid16_atan2Test_in(16 downto 0);

    -- aip1E_1_uid19_atan2Test(BITJOIN,18)@1
    aip1E_1_uid19_atan2Test_q <= STD_LOGIC_VECTOR((2 downto 1 => highBBits_uid17_atan2Test_b(0)) & highBBits_uid17_atan2Test_b) & lowRangeB_uid16_atan2Test_b;

    -- aip1E_uid30_atan2Test(BITSELECT,29)@1
    aip1E_uid30_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_1_uid19_atan2Test_q(18 downto 0));
    aip1E_uid30_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid30_atan2Test_in(18 downto 0));

    -- aip1E_2NA_uid45_atan2Test(BITJOIN,44)@1
    aip1E_2NA_uid45_atan2Test_q <= aip1E_uid30_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_2sumAHighB_uid46_atan2Test(ADDSUB,45)@1
    aip1E_2sumAHighB_uid46_atan2Test_s <= redist7_invSignOfSelectionSignal_uid36_atan2Test_q_1_q;
    aip1E_2sumAHighB_uid46_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => aip1E_2NA_uid45_atan2Test_q(20)) & aip1E_2NA_uid45_atan2Test_q));
    aip1E_2sumAHighB_uid46_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 19 => cstArcTan2Mi_1_uid35_atan2Test_q(18)) & cstArcTan2Mi_1_uid35_atan2Test_q));
    aip1E_2sumAHighB_uid46_atan2Test_combproc: PROCESS (aip1E_2sumAHighB_uid46_atan2Test_a, aip1E_2sumAHighB_uid46_atan2Test_b, aip1E_2sumAHighB_uid46_atan2Test_s)
    BEGIN
        IF (aip1E_2sumAHighB_uid46_atan2Test_s = "1") THEN
            aip1E_2sumAHighB_uid46_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2sumAHighB_uid46_atan2Test_a) + SIGNED(aip1E_2sumAHighB_uid46_atan2Test_b));
        ELSE
            aip1E_2sumAHighB_uid46_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2sumAHighB_uid46_atan2Test_a) - SIGNED(aip1E_2sumAHighB_uid46_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_2sumAHighB_uid46_atan2Test_q <= aip1E_2sumAHighB_uid46_atan2Test_o(21 downto 0);

    -- aip1E_uid49_atan2Test(BITSELECT,48)@1
    aip1E_uid49_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_2sumAHighB_uid46_atan2Test_q(20 downto 0));
    aip1E_uid49_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid49_atan2Test_in(20 downto 0));

    -- aip1E_3NA_uid64_atan2Test(BITJOIN,63)@1
    aip1E_3NA_uid64_atan2Test_q <= aip1E_uid49_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_3sumAHighB_uid65_atan2Test(ADDSUB,64)@1
    aip1E_3sumAHighB_uid65_atan2Test_s <= redist6_invSignOfSelectionSignal_uid55_atan2Test_q_1_q;
    aip1E_3sumAHighB_uid65_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 23 => aip1E_3NA_uid64_atan2Test_q(22)) & aip1E_3NA_uid64_atan2Test_q));
    aip1E_3sumAHighB_uid65_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 20 => cstArcTan2Mi_2_uid54_atan2Test_q(19)) & cstArcTan2Mi_2_uid54_atan2Test_q));
    aip1E_3sumAHighB_uid65_atan2Test_combproc: PROCESS (aip1E_3sumAHighB_uid65_atan2Test_a, aip1E_3sumAHighB_uid65_atan2Test_b, aip1E_3sumAHighB_uid65_atan2Test_s)
    BEGIN
        IF (aip1E_3sumAHighB_uid65_atan2Test_s = "1") THEN
            aip1E_3sumAHighB_uid65_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3sumAHighB_uid65_atan2Test_a) + SIGNED(aip1E_3sumAHighB_uid65_atan2Test_b));
        ELSE
            aip1E_3sumAHighB_uid65_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3sumAHighB_uid65_atan2Test_a) - SIGNED(aip1E_3sumAHighB_uid65_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_3sumAHighB_uid65_atan2Test_q <= aip1E_3sumAHighB_uid65_atan2Test_o(23 downto 0);

    -- aip1E_uid68_atan2Test(BITSELECT,67)@1
    aip1E_uid68_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_3sumAHighB_uid65_atan2Test_q(22 downto 0));
    aip1E_uid68_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid68_atan2Test_in(22 downto 0));

    -- aip1E_4NA_uid83_atan2Test(BITJOIN,82)@1
    aip1E_4NA_uid83_atan2Test_q <= aip1E_uid68_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_4sumAHighB_uid84_atan2Test(ADDSUB,83)@1
    aip1E_4sumAHighB_uid84_atan2Test_s <= invSignOfSelectionSignal_uid74_atan2Test_q;
    aip1E_4sumAHighB_uid84_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => aip1E_4NA_uid83_atan2Test_q(24)) & aip1E_4NA_uid83_atan2Test_q));
    aip1E_4sumAHighB_uid84_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 21 => cstArcTan2Mi_3_uid73_atan2Test_q(20)) & cstArcTan2Mi_3_uid73_atan2Test_q));
    aip1E_4sumAHighB_uid84_atan2Test_combproc: PROCESS (aip1E_4sumAHighB_uid84_atan2Test_a, aip1E_4sumAHighB_uid84_atan2Test_b, aip1E_4sumAHighB_uid84_atan2Test_s)
    BEGIN
        IF (aip1E_4sumAHighB_uid84_atan2Test_s = "1") THEN
            aip1E_4sumAHighB_uid84_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4sumAHighB_uid84_atan2Test_a) + SIGNED(aip1E_4sumAHighB_uid84_atan2Test_b));
        ELSE
            aip1E_4sumAHighB_uid84_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4sumAHighB_uid84_atan2Test_a) - SIGNED(aip1E_4sumAHighB_uid84_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_4sumAHighB_uid84_atan2Test_q <= aip1E_4sumAHighB_uid84_atan2Test_o(25 downto 0);

    -- aip1E_uid87_atan2Test(BITSELECT,86)@1
    aip1E_uid87_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_4sumAHighB_uid84_atan2Test_q(24 downto 0));
    aip1E_uid87_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid87_atan2Test_in(24 downto 0));

    -- aip1E_5NA_uid104_atan2Test(BITJOIN,103)@1
    aip1E_5NA_uid104_atan2Test_q <= aip1E_uid87_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_5sumAHighB_uid105_atan2Test(ADDSUB,104)@1
    aip1E_5sumAHighB_uid105_atan2Test_s <= invSignOfSelectionSignal_uid95_atan2Test_q;
    aip1E_5sumAHighB_uid105_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 27 => aip1E_5NA_uid104_atan2Test_q(26)) & aip1E_5NA_uid104_atan2Test_q));
    aip1E_5sumAHighB_uid105_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 22 => cstArcTan2Mi_4_uid94_atan2Test_q(21)) & cstArcTan2Mi_4_uid94_atan2Test_q));
    aip1E_5sumAHighB_uid105_atan2Test_combproc: PROCESS (aip1E_5sumAHighB_uid105_atan2Test_a, aip1E_5sumAHighB_uid105_atan2Test_b, aip1E_5sumAHighB_uid105_atan2Test_s)
    BEGIN
        IF (aip1E_5sumAHighB_uid105_atan2Test_s = "1") THEN
            aip1E_5sumAHighB_uid105_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5sumAHighB_uid105_atan2Test_a) + SIGNED(aip1E_5sumAHighB_uid105_atan2Test_b));
        ELSE
            aip1E_5sumAHighB_uid105_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5sumAHighB_uid105_atan2Test_a) - SIGNED(aip1E_5sumAHighB_uid105_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_5sumAHighB_uid105_atan2Test_q <= aip1E_5sumAHighB_uid105_atan2Test_o(27 downto 0);

    -- aip1E_uid108_atan2Test(BITSELECT,107)@1
    aip1E_uid108_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_5sumAHighB_uid105_atan2Test_q(26 downto 0));
    aip1E_uid108_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid108_atan2Test_in(26 downto 0));

    -- redist3_aip1E_uid108_atan2Test_b_1(DELAY,193)
    redist3_aip1E_uid108_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid108_atan2Test_b, xout => redist3_aip1E_uid108_atan2Test_b_1_q, clk => clk, aclr => areset );

    -- aip1E_6NA_uid121_atan2Test(BITJOIN,120)@2
    aip1E_6NA_uid121_atan2Test_q <= redist3_aip1E_uid108_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_6sumAHighB_uid122_atan2Test(ADDSUB,121)@2
    aip1E_6sumAHighB_uid122_atan2Test_s <= redist2_invSignOfSelectionSignal_uid116_atan2Test_q_1_q;
    aip1E_6sumAHighB_uid122_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => aip1E_6NA_uid121_atan2Test_q(28)) & aip1E_6NA_uid121_atan2Test_q));
    aip1E_6sumAHighB_uid122_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 23 => cstArcTan2Mi_5_uid115_atan2Test_q(22)) & cstArcTan2Mi_5_uid115_atan2Test_q));
    aip1E_6sumAHighB_uid122_atan2Test_combproc: PROCESS (aip1E_6sumAHighB_uid122_atan2Test_a, aip1E_6sumAHighB_uid122_atan2Test_b, aip1E_6sumAHighB_uid122_atan2Test_s)
    BEGIN
        IF (aip1E_6sumAHighB_uid122_atan2Test_s = "1") THEN
            aip1E_6sumAHighB_uid122_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6sumAHighB_uid122_atan2Test_a) + SIGNED(aip1E_6sumAHighB_uid122_atan2Test_b));
        ELSE
            aip1E_6sumAHighB_uid122_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6sumAHighB_uid122_atan2Test_a) - SIGNED(aip1E_6sumAHighB_uid122_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_6sumAHighB_uid122_atan2Test_q <= aip1E_6sumAHighB_uid122_atan2Test_o(29 downto 0);

    -- aip1E_uid125_atan2Test(BITSELECT,124)@2
    aip1E_uid125_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_6sumAHighB_uid122_atan2Test_q(28 downto 0));
    aip1E_uid125_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid125_atan2Test_in(28 downto 0));

    -- aip1E_7NA_uid138_atan2Test(BITJOIN,137)@2
    aip1E_7NA_uid138_atan2Test_q <= aip1E_uid125_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_7sumAHighB_uid139_atan2Test(ADDSUB,138)@2
    aip1E_7sumAHighB_uid139_atan2Test_s <= redist1_invSignOfSelectionSignal_uid133_atan2Test_q_1_q;
    aip1E_7sumAHighB_uid139_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => aip1E_7NA_uid138_atan2Test_q(30)) & aip1E_7NA_uid138_atan2Test_q));
    aip1E_7sumAHighB_uid139_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 24 => cstArcTan2Mi_6_uid132_atan2Test_q(23)) & cstArcTan2Mi_6_uid132_atan2Test_q));
    aip1E_7sumAHighB_uid139_atan2Test_combproc: PROCESS (aip1E_7sumAHighB_uid139_atan2Test_a, aip1E_7sumAHighB_uid139_atan2Test_b, aip1E_7sumAHighB_uid139_atan2Test_s)
    BEGIN
        IF (aip1E_7sumAHighB_uid139_atan2Test_s = "1") THEN
            aip1E_7sumAHighB_uid139_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7sumAHighB_uid139_atan2Test_a) + SIGNED(aip1E_7sumAHighB_uid139_atan2Test_b));
        ELSE
            aip1E_7sumAHighB_uid139_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7sumAHighB_uid139_atan2Test_a) - SIGNED(aip1E_7sumAHighB_uid139_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_7sumAHighB_uid139_atan2Test_q <= aip1E_7sumAHighB_uid139_atan2Test_o(31 downto 0);

    -- aip1E_uid142_atan2Test(BITSELECT,141)@2
    aip1E_uid142_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_7sumAHighB_uid139_atan2Test_q(30 downto 0));
    aip1E_uid142_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid142_atan2Test_in(30 downto 0));

    -- aip1E_8NA_uid155_atan2Test(BITJOIN,154)@2
    aip1E_8NA_uid155_atan2Test_q <= aip1E_uid142_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_8sumAHighB_uid156_atan2Test(ADDSUB,155)@2
    aip1E_8sumAHighB_uid156_atan2Test_s <= invSignOfSelectionSignal_uid153_atan2Test_q;
    aip1E_8sumAHighB_uid156_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => aip1E_8NA_uid155_atan2Test_q(32)) & aip1E_8NA_uid155_atan2Test_q));
    aip1E_8sumAHighB_uid156_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 25 => cstArcTan2Mi_7_uid149_atan2Test_q(24)) & cstArcTan2Mi_7_uid149_atan2Test_q));
    aip1E_8sumAHighB_uid156_atan2Test_combproc: PROCESS (aip1E_8sumAHighB_uid156_atan2Test_a, aip1E_8sumAHighB_uid156_atan2Test_b, aip1E_8sumAHighB_uid156_atan2Test_s)
    BEGIN
        IF (aip1E_8sumAHighB_uid156_atan2Test_s = "1") THEN
            aip1E_8sumAHighB_uid156_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8sumAHighB_uid156_atan2Test_a) + SIGNED(aip1E_8sumAHighB_uid156_atan2Test_b));
        ELSE
            aip1E_8sumAHighB_uid156_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8sumAHighB_uid156_atan2Test_a) - SIGNED(aip1E_8sumAHighB_uid156_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_8sumAHighB_uid156_atan2Test_q <= aip1E_8sumAHighB_uid156_atan2Test_o(33 downto 0);

    -- aip1E_uid159_atan2Test(BITSELECT,158)@2
    aip1E_uid159_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_8sumAHighB_uid156_atan2Test_q(32 downto 0));
    aip1E_uid159_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid159_atan2Test_in(32 downto 0));

    -- aip1E_9NA_uid172_atan2Test(BITJOIN,171)@2
    aip1E_9NA_uid172_atan2Test_q <= aip1E_uid159_atan2Test_b & aip1E_2CostZeroPaddingA_uid44_atan2Test_q;

    -- aip1E_9sumAHighB_uid173_atan2Test(ADDSUB,172)@2
    aip1E_9sumAHighB_uid173_atan2Test_s <= invSignOfSelectionSignal_uid170_atan2Test_q;
    aip1E_9sumAHighB_uid173_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => aip1E_9NA_uid172_atan2Test_q(34)) & aip1E_9NA_uid172_atan2Test_q));
    aip1E_9sumAHighB_uid173_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 26 => cstArcTan2Mi_8_uid166_atan2Test_q(25)) & cstArcTan2Mi_8_uid166_atan2Test_q));
    aip1E_9sumAHighB_uid173_atan2Test_combproc: PROCESS (aip1E_9sumAHighB_uid173_atan2Test_a, aip1E_9sumAHighB_uid173_atan2Test_b, aip1E_9sumAHighB_uid173_atan2Test_s)
    BEGIN
        IF (aip1E_9sumAHighB_uid173_atan2Test_s = "1") THEN
            aip1E_9sumAHighB_uid173_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9sumAHighB_uid173_atan2Test_a) + SIGNED(aip1E_9sumAHighB_uid173_atan2Test_b));
        ELSE
            aip1E_9sumAHighB_uid173_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9sumAHighB_uid173_atan2Test_a) - SIGNED(aip1E_9sumAHighB_uid173_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_9sumAHighB_uid173_atan2Test_q <= aip1E_9sumAHighB_uid173_atan2Test_o(35 downto 0);

    -- aip1E_uid176_atan2Test(BITSELECT,175)@2
    aip1E_uid176_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_9sumAHighB_uid173_atan2Test_q(34 downto 0));
    aip1E_uid176_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid176_atan2Test_in(34 downto 0));

    -- alphaPreRnd_uid177_atan2Test(BITSELECT,176)@2
    alphaPreRnd_uid177_atan2Test_b <= aip1E_uid176_atan2Test_b(34 downto 25);

    -- alphaPostRnd_uid180_atan2Test(ADD,179)@2
    alphaPostRnd_uid180_atan2Test_a <= STD_LOGIC_VECTOR("0" & alphaPreRnd_uid177_atan2Test_b);
    alphaPostRnd_uid180_atan2Test_b <= STD_LOGIC_VECTOR("0000000000" & VCC_q);
    alphaPostRnd_uid180_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(alphaPostRnd_uid180_atan2Test_a) + UNSIGNED(alphaPostRnd_uid180_atan2Test_b));
    alphaPostRnd_uid180_atan2Test_q <= alphaPostRnd_uid180_atan2Test_o(10 downto 0);

    -- atanRes_uid181_atan2Test(BITSELECT,180)@2
    atanRes_uid181_atan2Test_in <= STD_LOGIC_VECTOR(alphaPostRnd_uid180_atan2Test_q(9 downto 0));
    atanRes_uid181_atan2Test_b <= STD_LOGIC_VECTOR(atanRes_uid181_atan2Test_in(9 downto 1));

    -- xNotZero_uid8_atan2Test(LOGICAL,7)@0 + 1
    xNotZero_uid8_atan2Test_qi <= "1" WHEN x /= "000000000000" ELSE "0";
    xNotZero_uid8_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid8_atan2Test_qi, xout => xNotZero_uid8_atan2Test_q, clk => clk, aclr => areset );

    -- redist8_xNotZero_uid8_atan2Test_q_2(DELAY,198)
    redist8_xNotZero_uid8_atan2Test_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid8_atan2Test_q, xout => redist8_xNotZero_uid8_atan2Test_q_2_q, clk => clk, aclr => areset );

    -- xZero_uid9_atan2Test(LOGICAL,8)@2
    xZero_uid9_atan2Test_q <= not (redist8_xNotZero_uid8_atan2Test_q_2_q);

    -- yNotZero_uid6_atan2Test(LOGICAL,5)@0 + 1
    yNotZero_uid6_atan2Test_qi <= "1" WHEN y /= "000000000000" ELSE "0";
    yNotZero_uid6_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid6_atan2Test_qi, xout => yNotZero_uid6_atan2Test_q, clk => clk, aclr => areset );

    -- redist9_yNotZero_uid6_atan2Test_q_2(DELAY,199)
    redist9_yNotZero_uid6_atan2Test_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid6_atan2Test_q, xout => redist9_yNotZero_uid6_atan2Test_q_2_q, clk => clk, aclr => areset );

    -- yZero_uid7_atan2Test(LOGICAL,6)@2
    yZero_uid7_atan2Test_q <= not (redist9_yNotZero_uid6_atan2Test_q_2_q);

    -- concXZeroYZero_uid188_atan2Test(BITJOIN,187)@2
    concXZeroYZero_uid188_atan2Test_q <= xZero_uid9_atan2Test_q & yZero_uid7_atan2Test_q;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- atanResPostExc_uid189_atan2Test(MUX,188)@2
    atanResPostExc_uid189_atan2Test_s <= concXZeroYZero_uid188_atan2Test_q;
    atanResPostExc_uid189_atan2Test_combproc: PROCESS (atanResPostExc_uid189_atan2Test_s, atanRes_uid181_atan2Test_b, cstZeroOutFormat_uid182_atan2Test_q, cstPiO2OutFormat_mergedSignalTMB_uid186_atan2Test_q)
    BEGIN
        CASE (atanResPostExc_uid189_atan2Test_s) IS
            WHEN "00" => atanResPostExc_uid189_atan2Test_q <= atanRes_uid181_atan2Test_b;
            WHEN "01" => atanResPostExc_uid189_atan2Test_q <= cstZeroOutFormat_uid182_atan2Test_q;
            WHEN "10" => atanResPostExc_uid189_atan2Test_q <= cstPiO2OutFormat_mergedSignalTMB_uid186_atan2Test_q;
            WHEN "11" => atanResPostExc_uid189_atan2Test_q <= cstZeroOutFormat_uid182_atan2Test_q;
            WHEN OTHERS => atanResPostExc_uid189_atan2Test_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xOut(GPOUT,4)@2
    q <= atanResPostExc_uid189_atan2Test_q;

END normal;

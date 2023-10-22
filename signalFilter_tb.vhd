----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/10/21 23:10:03
-- Design Name: 
-- Module Name: signalFilter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity signalFilter_tb is
--  Port ( );
end signalFilter_tb;

architecture Behavioral of signalFilter_tb is
signal tb_clk               : std_logic := '0';
signal tb_nrst              : std_logic := '0';
signal tb_signal            : std_logic := '0';
signal tb_signalFilteredOutDef  : std_logic;
signal tb_signalFilteredOut     : std_logic;

signal tb_risingPulse    : std_logic;
signal tb_fallingPulse   : std_logic;

begin

tb_clkGenrate : process
begin
    tb_clk <= '0';
    wait for 5ns;
    tb_clk <= '1';
    wait for 5ns;
end process;

tb_nrstGenerate: process
begin
    tb_nrst <= '0';
    wait for 87ns;
    tb_nrst <= '1';
    wait;
end process;

tb_signalGenerate : process
begin
    tb_signal <= '0';
    wait for 5ns;
    tb_signal <= '1';
    wait for 4ns;
    tb_signal <= '0';
    wait for 3ns;
    tb_signal <= '1';
    wait for 2ns;
    tb_signal <= '0';
    wait for 2ns;
    tb_signal <= '1';
    wait for 2ns;
    tb_signal <= '0';
    wait for 7ns;
    tb_signal <= '1';
    wait for  99ns;
    tb_signal <= '0';
    wait for 7ns;
    tb_signal <= '1';
    wait for 4ns;
    tb_signal <= '0';
    wait for 3ns;
    tb_signal <= '1';
    wait for 2ns;
    tb_signal <= '0';
    wait for 2ns;
    tb_signal <= '1';
    wait for 2ns;
    tb_signal <= '0';
    wait for 84ns;
end process;

signalFilterInstDefault: entity work.signalFilter
Generic map ( p_filterLength => 3)
port map (
    i_mainClk       => tb_clk,
    i_nrst          => tb_nrst,
    i_signal        => tb_signal,
    o_signalFiltered=> tb_signalFilteredOutDef
);

signalFilterInst: entity work.signalFilter
Generic map (p_filterLength => 8)
port map (
    i_mainClk       => tb_clk,
    i_nrst          => tb_nrst,
    i_signal        => tb_signal,
    o_signalFiltered=> tb_signalFilteredOut
);

signalEdgeDetect:entity work.signalEdgeDetect
    Generic map(
        p_mode         => '1' -- parameter: mode 0:Sequential logic(have 1 clock delay (default)
                                                 --                 1:Combinational logic
    )
    Port map (
        i_mainClk       => tb_clk,  -- input: work clock
        i_nrst          => tb_nrst,  -- input: reset active low
        i_signal        => tb_signalFilteredOutDef,  -- input: origin signal
        o_risingPulse   => tb_risingPulse,  -- output:input signal ringing pulse
        o_fallingPulse  => tb_fallingPulse   -- output:input signal falliing pulse
    );


end Behavioral;

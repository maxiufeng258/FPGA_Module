----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/10/21 21:28:07
-- Design Name: 
-- Module Name: signalEdgeDetect_tb - Behavioral
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

entity signalEdgeDetect_tb is
--  Port ( );
end signalEdgeDetect_tb;

architecture Behavioral of signalEdgeDetect_tb is

signal tb_clk   : std_logic := '0';
signal tb_nrst  : std_logic := '0';
signal tb_signal: std_logic := '0';
signal tb_risingPulse : std_logic;
signal tb_fallingPulse: std_logic;

signal tb_risingPulseNoDelay    : std_logic;
signal tb_fallingPulseNoDelay   : std_logic;

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
    wait for 55ns;
    tb_signal <= '1';
    wait for 20ns;
    tb_signal <= '0';
    wait for 60ns;
    tb_signal <= '1';
    wait for 70ns;
    tb_signal <= '0';
    wait for  5ns;
end process;

tb_signalEdgeDetect : entity work.signalEdgeDetect
    port map (
        i_mainClk       => tb_clk,  -- input: work clock
        i_nrst          => tb_nrst,  -- input: reset active low
        i_signal        => tb_signal,  -- input: origin signal
        o_risingPulse   => tb_risingPulse,  -- output:input signal ringing pulse
        o_fallingPulse  => tb_fallingPulse  -- output:input signal falliing pulse
    );

tb_signalEdgeDetectNoDelay : entity work.signalEdgeDetect
    Generic map (
        p_mode  =>  '1'
    )
    port map (
        i_mainClk       => tb_clk,  -- input: work clock
        i_nrst          => tb_nrst,  -- input: reset active low
        i_signal        => tb_signal,  -- input: origin signal
        o_risingPulse   => tb_risingPulseNoDelay,  -- output:input signal ringing pulse
        o_fallingPulse  => tb_fallingPulseNoDelay  -- output:input signal falliing pulse
    );


end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ma,Xiufeng
-- 
-- Create Date: 2023/10/21 20:57:39
-- Design Name: 
-- Module Name: signalEdgeDetect - RTL
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

entity signalEdgeDetect is
    Generic (
        p_mode          :   std_logic   :=  '0' -- parameter: mode 0:Sequential logic(have 1 clock delay (default)
                                                 --                 1:Combinational logic
    );
    Port (
        i_mainClk       :   in      std_logic;  -- input: work clock
        i_nrst          :   in      std_logic;  -- input: reset active low
        i_signal        :   in      std_logic;  -- input: origin signal
        o_risingPulse   :   out     std_logic;  -- output:input signal ringing pulse
        o_fallingPulse  :   out     std_logic   -- output:input signal falliing pulse
    );
end signalEdgeDetect;

architecture RTL of signalEdgeDetect is

-- Define internal registers
-- Receive input signal i_signal
signal  r_signal        :   std_logic   :=  '0';
-- r_signal buffer, delayed by one clock
signal  r_signalBuffer  :   std_logic   :=  '0';

signal  r_risingPulse   :   std_logic   :=  '0';
signal  r_fallingPulse  :   std_logic   :=  '0';

begin

r_signal    <=  i_signal;

signalBuffer: process(i_mainClk, i_nrst)
    begin
        if (i_nrst = '0') then
            r_signalBuffer  <=  '0';
        elsif (rising_edge(i_mainClk)) then
            r_signalBuffer  <=  r_signal;
        end if;
    end process;

risingEdgeDetect: process(i_mainClk, i_nrst)
    begin
        if (i_nrst = '0') then
            r_risingPulse   <=  '0';
        elsif (rising_edge(i_mainClk)) then
            if (r_signal = '1' and r_signalBuffer = '0') then
                r_risingPulse <= '1';
            else
                r_risingPulse <= '0';
            end if;
        end if;
    end process;

fallingEdgeDetect: process(i_mainClk, i_nrst)
    begin
        if (i_nrst = '0') then
            r_fallingPulse   <=  '0';
        elsif (rising_edge(i_mainClk)) then
            if (r_signal = '0' and r_signalBuffer = '1') then
                r_fallingPulse <= '1';
            else
                r_fallingPulse <= '0';
            end if;
        end if;
    end process;
    
-- edge pulse signal output
o_risingPulse   <=  r_risingPulse when (p_mode='0')
               else '1'           when (p_mode='1'and r_signal='1' and r_signalBuffer='0' and i_nrst='1')
               else '0';
o_fallingPulse  <= r_fallingPulse when (p_mode='0')
               else '1'           when (p_mode='1'and r_signal='0' and r_signalBuffer='1' and i_nrst='1')
               else '0';

end RTL;

-- END --

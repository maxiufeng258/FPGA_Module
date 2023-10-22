----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ma,Xiufeng
-- 
-- Create Date: 2023/10/21 22:41:03
-- Design Name: 
-- Module Name: signalFilter - RTL
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

entity signalFilter is
    Generic (
        p_filterLength  :   integer :=  3   -- Filter register vector length
    );
    Port (
        i_mainClk       :   in      std_logic;  -- input: work clock
        i_nrst          :   in      std_logic;  -- input: reset active low
        i_signal        :   in      std_logic;  -- input: origin signal
        o_signalFiltered:   out     std_logic   -- output:filtered signal output
);
end signalFilter;

architecture RTL of signalFilter is

-- Define internal registers
-- r_signal buffer, delayed by one clock
signal  r_signalBuffer  :   std_logic   :=  '0';
-- r_signal filter register vector
signal  r_signalFilter  :   std_logic_vector(p_filterLength-1 downto 0) :=  (others=>'0');
constant c_signalFilterOne: std_logic_vector(p_filterLength-1 downto 0) :=  (others=>'1');
constant c_signalFilterZero:std_logic_vector(p_filterLength-1 downto 0) :=  (others=>'0');

-- r_signalFiltered filtered signal
signal  r_signalFiltered :  std_logic := '0';

begin

process (i_mainClk, i_nrst)
    begin
        if (i_nrst = '0') then
            r_signalBuffer  <= '0';
            r_signalFilter  <=  (others=>'0');
            r_signalFiltered<=  '0';
        elsif (rising_edge(i_mainClk)) then
            r_signalBuffer <= i_signal;
            r_signalFilter(r_signalFilter'left) <= r_signalBuffer;
            r_signalFilter(r_signalFilter'left-1 downto 0)<=r_signalFilter(r_signalFilter'left downto 1);
            if (r_signalFilter = c_signalFilterOne) then
                r_signalFiltered <= '1';
            elsif (r_signalFilter = c_signalFilterZero) then
                r_signalFiltered <= '0';
            else
                r_signalFiltered <= r_signalFiltered;
            end if;
        end if;
    end process;

    o_signalFiltered    <=  r_signalFiltered;

end RTL;

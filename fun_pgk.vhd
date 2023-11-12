----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/11/11 19:42:07
-- Design Name: 
-- Module Name: fun_pgk - Behavioral
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
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
-- Package Declaration Section
package example_package is
 
  constant c_PIXELS : integer := 65536;
 
  type t_FROM_FIFO is record
    wr_full  : std_logic;
    rd_empty : std_logic;
  end record t_FROM_FIFO;  
   
  component example_component is
    port (
      i_data  : in  std_logic;
      o_rsult : out std_logic); 
  end component example_component;

    --* Hex(4bit)转换成ASCII(8bit)
    --* arg: i_hexVal   如: "1111"-F
    --* return: std_logic_vector (7 downto 0) ascii 'F'
    function hex2ascii (
        i_hexVal    :   std_logic_vector(3 downto 0))
        return std_logic_vector;

    --* Ascii（8bit)转换成Hex(4bit)
    --* arg: i_asciiVal 如："00110000" x"30" - '0'
    --* return: std_logic_vector (3 downto 0) hex 0
    function ascii2hex (
        i_asciiVal  :   std_logic_vector(7 downto 0))
        return std_logic_vector;


end package example_package;
 
-- Package Body Section
package body example_package is

    --* Hex(4bit)转换成ASCII(8bit)
    --* arg: i_hexVal   如: "1111"-F
    --* return: std_logic_vector (7 downto 0) ascii 'f'
    function hex2ascii (
        i_hexVal    :   std_logic_vector(3 downto 0))
        return std_logic_vector is
        variable tempHexVal: std_logic_vector(7 downto 0):="00000000";
    begin
        tempHexVal := "0000" & i_hexVal;
        if (i_hexVal>=0 and i_hexVal<=9) then   -- 数字0-9
            return (tempHexVal + x"30");
        -- elsif (i_hexVal<=10 or i_hexVal>=15) then
        else
            return (tempHexVal - 10 + x"61"); -- 数字10(A)-15(F)
        end if;
    end;

    --* Ascii（8bit)转换成Hex(4bit)
    --* arg: i_asciiVal 如："00110000" x"30" - '0'
    --* return: std_logic_vector (3 downto 0) hex 0
    function ascii2hex (
        i_asciiVal  :   std_logic_vector(7 downto 0))
        return std_logic_vector is
        variable tempAsciiVal: std_logic_vector(7 downto 0):="00000000";
    begin
        if (i_asciiVal>=x"30" and i_asciiVal<=x"39") then -- '0'-'9'
            tempAsciiVal := i_asciiVal-x"30";
        elsif ((i_asciiVal>=x"41" and i_asciiVal<=x"46") -- 'A'-'F'
             or (i_asciiVal>=x"61" and i_asciiVal<=x"66")) then
            tempAsciiVal := i_asciiVal-x"41"+10;
        else
            tempAsciiVal := tempAsciiVal;   -- 其他符号不考虑
        end if;
        return tempAsciiVal(3 downto 0);
    end;
 
end package body example_package;

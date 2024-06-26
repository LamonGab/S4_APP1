----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 02:07:16 PM
-- Design Name: 
-- Module Name: decodeur3_8 - Behavioral
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

entity decodeur3_8 is
    Port ( A2_3 : in STD_LOGIC_VECTOR (2 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0));
end decodeur3_8;

architecture Behavioral of decodeur3_8 is

begin
        LED <= "10000000" when A2_3 = "111" else
               "01000000" when A2_3 = "110" else
               "00100000" when A2_3 = "101" else
               "00010000" when A2_3 = "100" else
               "00001000" when A2_3 = "011" else
               "00000100" when A2_3 = "010" else
               "00000010" when A2_3 = "001" else
               "00000001" when A2_3 = "000" else
               "00000000";
end Behavioral;

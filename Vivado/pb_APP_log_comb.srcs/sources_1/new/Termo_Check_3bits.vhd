----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2024 09:53:26 AM
-- Design Name: 
-- Module Name: Termo_Check_3bits - Behavioral
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

entity Termo_Check_3bits is
    Port ( bits : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (3 downto 0));
end Termo_Check_3bits;

architecture Behavioral of Termo_Check_3bits is

begin

    result(3) <= '0';
    result(2) <= '0';
    result(1) <= (bits(1) AND bits(0));
    result(0) <= (bits(0) XOR bits(1) XOR bits(2));

end Behavioral;

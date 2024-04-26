----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2024 10:09:09 AM
-- Design Name: 
-- Module Name: error_check - Behavioral
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

entity error_check is
    Port ( bits : in STD_LOGIC_VECTOR (2 downto 0);
           erreur : out STD_LOGIC);
end error_check;

architecture Behavioral of error_check is

begin

    erreur <= ((bits(1) AND (NOT bits(0))) OR (bits(2) AND (NOT bits(1))));

end Behavioral;

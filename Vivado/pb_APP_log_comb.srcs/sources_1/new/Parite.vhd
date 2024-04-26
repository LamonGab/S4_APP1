----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 02:50:00 PM
-- Design Name: 
-- Module Name: Parite - Behavioral
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

entity Parite is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           S1 : in STD_LOGIC;
           Parite : out STD_LOGIC);
end Parite;

architecture Behavioral of Parite is

begin
    process (S1, ADCbin)
    begin
        case (ADCbin) is
            when "0000" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "0001" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "0010" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "0011" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "0100" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "0101" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "0110" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "0111" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "1000" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "1001" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "1010" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "1011" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "1100" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when "1101" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "1110" =>
                if S1 = '1' then
                    Parite <= '1';
                else
                    Parite <= '0';
                end if;
            when "1111" =>
                if S1 = '1' then
                    Parite <= '0';
                else
                    Parite <= '1';
                end if;
            when others =>
                Parite <= '0';
        end case;
    end process;
end Behavioral;

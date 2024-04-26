----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 08:16:39 PM
-- Design Name: 
-- Module Name: Mux - Behavioral
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

entity Mux is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : in STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : in STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : in STD_LOGIC_VECTOR (3 downto 0);
           erreur : in STD_LOGIC;
           BTN : in STD_LOGIC_VECTOR (1 downto 0);
           S2 : in STD_LOGIC;
           DAFF0 : out STD_LOGIC_VECTOR (3 downto 0);
           DAFF1 : out STD_LOGIC_VECTOR (3 downto 0));
end Mux;

architecture Behavioral of Mux is
component Parite is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           S1 : in STD_LOGIC;
           Parite : out STD_LOGIC);
end component;

begin
    process (erreur, BTN, S2)
    begin
        if (S2 = '1' OR BTN = "11" OR erreur = '1') then
            DAFF0 <= "1110"; -- E
            DAFF1 <= "1111"; -- r
        
        else
            case (BTN) is
                when "00" =>
                    DAFF0 <= Dizaines;
                    DAFF1 <= Unites_ns;
                when "01" =>
                    DAFF0 <= "0000";
                    DAFF1 <= ADCbin;
                when "10" =>
                    DAFF0 <= Code_signe;
                    DAFF1 <= Unite_s;
                when others =>
                    DAFF0 <= "0000";
                    DAFF1 <= "0000";
            end case;
        end if;
    end process;
end Behavioral;

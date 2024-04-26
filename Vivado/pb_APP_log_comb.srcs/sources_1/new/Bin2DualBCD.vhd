----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 04:07:24 PM
-- Design Name: 
-- Module Name: Bin2DualBCD - Behavioral
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

entity Bin2DualBCD is
    Port ( Unite_s : out STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           ADCbin : in STD_LOGIC_VECTOR (3 downto 0));
end Bin2DualBCD;

architecture Behavioral of Bin2DualBCD is
component Bin2DualBCD_NS is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Bin2DualBCD_S is
    Port ( Moins5 : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Moins_5 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Moins5 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal temp_moins5 : STD_LOGIC_VECTOR (3 downto 0);
begin
    inst_Bin2DualBCD:Bin2DualBCD_NS
        port map ( 
            ADCbin => ADCbin,
            Dizaines => Dizaines,
            Unites_ns => Unites_ns);
            
    inst_Moins5:Moins_5
        port map ( 
            ADCbin => ADCbin,
            Moins5 => temp_moins5);
            
    inst_Bin2DualBCD_S:Bin2DualBCD_S
        port map ( 
            Moins5 => temp_moins5,
            Code_signe => Code_signe,
            Unite_s => Unite_s);

end Behavioral;

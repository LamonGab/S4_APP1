----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 01/09/2024 02:26:26 PM
-- Design Name:
-- Module Name: Fct2_3 - Behavioral
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

entity Fct2_3 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
end Fct2_3;

architecture Behavioral of Fct2_3 is

    signal m1, m3, m5, m7, m9: std_logic_vector (11 downto 0) := (others => '0');
    signal s1,s2,s3,s4: std_logic_vector (5 downto 0) := (others => '0');
    signal c1,c2,c3,c4: std_logic ;
   
    component Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           Ci : in STD_LOGIC;
           Co : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
   

begin

    m1(10) <= ADCbin(3);
    m1(9) <= ADCbin(2);
    m1(8) <= ADCbin(1);
    m1(7) <= ADCbin(0);
   
    m3(8) <= ADCbin(3);
    m3(7) <= ADCbin(2);
    m3(6) <= ADCbin(1);
    m3(5) <= ADCbin(0);
   
    m5(6) <= ADCbin(3);
    m5(5) <= ADCbin(2);
    m5(4) <= ADCbin(1);
    m5(3) <= ADCbin(0);
   
    m7(4) <= ADCbin(3);
    m7(3) <= ADCbin(2);
    m7(2) <= ADCbin(1);
    m7(1) <= ADCbin(0);
   
    m9(2) <= ADCbin(3);
    m9(1) <= ADCbin(2);
   
    inst1:Add4bits
        port map(
            X => m9(4 downto 1),
            Y => m7(4 downto 1),
            Ci => '0',
            S => s1(3 downto 0),
            Co => s1(4) );
       
   
    inst2:Add4bits
        port map(
            X => s1(5 downto 2),
            Y => m5(6 downto 3),
            Ci => '0',
            S => s2(3 downto 0),
            Co => s2(4));
       
       
    inst3:Add4bits
        port map(
            X => s2(5 downto 2),
            Y => m3(8 downto 5),
            Ci => '0',
            S => s3(3 downto 0),
            Co => s3(4));
       
       
    inst4:Add4bits
        port map(
            X => s3(5 downto 2),
            Y => m1(10 downto 7),
            Ci => '0',
            S => s4(3 downto 0),
            Co => s4(4));
       
    A2_3 <= s4(3 downto 1);
       

end Behavioral;
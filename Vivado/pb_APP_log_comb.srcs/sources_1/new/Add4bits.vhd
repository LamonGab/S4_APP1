----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 01:12:33 PM
-- Design Name: 
-- Module Name: Add4bits - Behavioral
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

entity Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           Ci : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC);
end Add4bits;

architecture Behavioral of Add4bits is
component Add1bitA is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;

component Add1bitB is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;

signal C1 : STD_LOGIC;
signal C2 : STD_LOGIC;
signal C3 : STD_LOGIC;
signal C4 : STD_LOGIC;

begin
    Add1bitA1:Add1bitA
        port map ( 
            X => X(0),
            Y => Y(0),
            Ci => '0',
            S => S(0),
            Co => C1);
            
    Add1bitA2:Add1bitA
        port map ( 
            X => X(1),
            Y => Y(1),
            Ci => C1,
            S => S(1),
            Co => C2);
            
    Add1bitB1:Add1bitB
        port map ( 
            X => X(2),
            Y => Y(2),
            Ci => C2,
            S => S(2),
            Co => C3);
            
    Add1bitB2:Add1bitB
        port map ( 
            X => X(3),
            Y => Y(3),
            Ci => C3,
            S => S(3),
            Co => Co);

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 10:17:50 PM
-- Design Name: 
-- Module Name: Thermo2Bin - Behavioral
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

entity Thermo2Bin is
    Port ( ADCth : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
end Thermo2Bin;

architecture Behavioral of Thermo2Bin is

    component Termo_Check_3bits is
        Port ( bits : in STD_LOGIC_VECTOR (2 downto 0);
               result : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component error_check is
        Port ( bits : in STD_LOGIC_VECTOR (2 downto 0);
               erreur : out STD_LOGIC);
    end component;
    
    component Add4bits is
        Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
               Y : in STD_LOGIC_VECTOR (3 downto 0);
               Ci : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               Co : out STD_LOGIC);
    end component;
    
    signal temp_result1 : STD_LOGIC_VECTOR (3 downto 0);
    signal temp_result2 : STD_LOGIC_VECTOR (3 downto 0);
    signal temp_result3 : STD_LOGIC_VECTOR (3 downto 0);
    signal temp_result4 : STD_LOGIC_VECTOR (3 downto 0);
    
    signal temp_erreur1 : STD_LOGIC;
    signal temp_erreur2 : STD_LOGIC;
    signal temp_erreur3 : STD_LOGIC;
    signal temp_erreur4 : STD_LOGIC;
    signal temp_erreur5 : STD_LOGIC;
    signal temp_erreur6 : STD_LOGIC;
    signal temp_erreur7 : STD_LOGIC;
    
    signal c1, c2, c3 : STD_LOGIC;
    signal s1, s2 : STD_LOGIC_VECTOR (3 downto 0);

begin

    inst_Check_3bits1:Termo_Check_3bits
        port map( bits => ADCth (2 downto 0),
                  result => temp_result1);
    
    inst_Check_3bits2:Termo_Check_3bits
        port map( bits => ADCth (5 downto 3),
                  result => temp_result2);
                  
    inst_Check_3bits3:Termo_Check_3bits
        port map( bits => ADCth (8 downto 6),
                  result => temp_result3);
                  
    inst_Check_3bits4:Termo_Check_3bits
        port map( bits => ADCth (11 downto 9),
                  result => temp_result4);
                  
                  
    inst_error_check1:error_check
        port map ( bits => ADCth (2 downto 0),
                   erreur => temp_erreur1);
                   
    inst_error_check2:error_check
        port map ( bits => ADCth (5 downto 3),
                   erreur => temp_erreur2);
                   
    inst_error_check3:error_check
        port map ( bits => ADCth (8 downto 6),
                   erreur => temp_erreur3);
                   
    inst_error_check4:error_check
        port map ( bits => ADCth (11 downto 9),
                   erreur => temp_erreur4);
                   
    inst_error_check5:error_check
        port map ( bits => ADCth (3 downto 1),
                   erreur => temp_erreur5);
                   
    inst_error_check6:error_check
        port map ( bits => ADCth (6 downto 4),
                   erreur => temp_erreur6);
                   
    inst_error_check7:error_check
        port map ( bits => ADCth (9 downto 7),
                   erreur => temp_erreur7);
                   
    erreur <= temp_erreur1 OR temp_erreur2 OR temp_erreur3 OR temp_erreur4 OR temp_erreur5 OR temp_erreur6 OR temp_erreur7;
    
    inst_Add4bits1:Add4bits
        port map ( X => temp_result1,
                   Y => temp_result2,
                   Ci => '0',
                   S => s1,
                   Co => c1);
                   
    inst_Add4bits2:Add4bits
        port map ( X => temp_result3,
                   Y => temp_result4,
                   Ci => c1,
                   S => s2,
                   Co => c2);
                   
    inst_Add4bits3:Add4bits
        port map ( X => s1,
                   Y => s2,
                   Ci => c2,
                   S => ADCbin,
                   Co => c3);
                   

end Behavioral;

---------------------------------------------------------------------------------------------
-- labo_adder4b_sol_tb.vhd
---------------------------------------------------------------------------------------------
-- Universit� de Sherbrooke - D�partement de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date R�vision   : 21 Avril 2020
-- Auteur(s)       : R�jean Fontaine, Daniel Dalle, Marc-Andr� T�trault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: carte Thermo12, Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Banc d'essai pour circuit combinatoire Laboratoire logique combinatoire
-- Version avec entr�es toutes combinatoires CIRCUIT COMPLET (TOP)
-- 
-- Revision v1 12 novembre 2018, 3 d�cembre 2018 D. Dalle 
-- Revision 30 Avril 2021, M-A Tetrault
--
---------------------------------------------------------------------------------------------
-- Notes :
-- L'entr�e retenue (i_cin) est g�n�r�e par l'interrupteur S1 de la carte Thermobin
--
---------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- requis pour enonc�s de type mem_valeurs_tests(to_integer( unsigned(table_valeurs_adr(9 downto 6) )));
USE ieee.numeric_std.ALL;          -- 
use IEEE.STD_LOGIC_UNSIGNED.ALL;   --


entity AppCombi2_top is
--  Port ( );
end AppCombi2_top;

architecture Behavioral of AppCombi2_top is

COMPONENT verif_show_affhex is
end COMPONENT;

component Thermo2Bin is
    Port ( ADCth : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
end component;


    signal ADCth_sim : STD_LOGIC_VECTOR (11 downto 0);
    signal ADCbin_sim : STD_LOGIC_VECTOR (3 downto 0);
    signal erreur_sim : STD_LOGIC;
    
   signal clk_sim : STD_LOGIC := '0';
   signal vecteur_test_sim   :  STD_LOGIC_VECTOR (13 DOWNTO 0) := (others => '0');


   constant sysclk_Period  : time := 8 ns;
   


----------------------------------------------------------------------------
-- declaration d'un tableau pour soumettre un vecteur de test  
----------------------------------------------------------------------------  
 type table_valeurs_tests is array (integer range 0 to 24) of std_logic_vector(11 downto 0);
    constant mem_valeurs_tests : table_valeurs_tests := 
    ( 
        "000000000000",
        "000000000001",
        "000000000011",
        "000000000111",
        "000000001111",
        "000000011111",
        "000000111111",
        "000001111111",
        "000011111111",
        "000111111111",
        "001111111111",
        "011111111111",
        "111111111111",
        "101111111111",
        "110111111111",
        "111011111111",
        "111101111111",
        "111110111111",
        "111111011111",
        "111111101111",
        "111111110111",
        "111111111011",
        "111111111101",
        "111111111110",
        "011011011011",
    -- conserver la ligne ci-bas.
    others => "000000000000"
    );
----------------------------------------------------------------------------

begin


-- Pattes du FPGA Zybo-Z7
uut: Thermo2Bin
   PORT MAP(
        ADCth => ADCth_sim,
        ADCbin => ADCbin_sim,
        erreur => erreur_sim);
   
   

	-- Section banc de test
    ----------------------------------------
	-- generation horloge 
	----------------------------------------
   process
   begin
       clk_sim <= '1';  -- init
       loop
           wait for sysclk_Period/2;
           clk_sim <= not clk_sim;    -- invert clock value
       end loop;
   end process;  
	----------------------------------------
   
   ----------------------------------------
   -- test bench
   tb : PROCESS
       variable delai_sim : time  := 50 ns;
       variable table_valeurs_adr : integer range 0 to 63;

      BEGIN
         -- Phase 1
         wait for delai_sim;
         table_valeurs_adr := 0;
         -- simuler une sequence de valeurs a l'entree 
         for index in 0 to   mem_valeurs_tests'length-1 loop
              ADCth_sim <= mem_valeurs_tests(table_valeurs_adr);
              wait for delai_sim;
			  --assert (resultat_attendu /= (probe_adder_result) ) report "Resultat pas celui pr�vu." severity warning; 
              table_valeurs_adr := table_valeurs_adr + 1;
			  if(table_valeurs_adr = 63) then
				exit;
			  end if;
         end loop; 
           
         WAIT; -- will wait forever
      END PROCESS;

END Behavioral;

---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date            : 21 Avril 2020
-- Auteur(s)       : Réjean Fontaine, Daniel Dalle, Marc-André Tétrault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Circuit utilitaire pour le laboratoire et la problématique de logique combinatoire
--
---------------------------------------------------------------------------------------------
-- À faire :
-- Voir le guide de l'APP
--    Insérer les modules additionneurs ("components" et "instances")
--
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity AppCombi_top is
  port ( 
          i_btn       : in    std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
          i_sw        : in    std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
          sysclk      : in    std_logic;                     -- horloge systeme
          o_SSD       : out   std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
          o_led       : out   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
          o_led6_r    : out   std_logic;                     -- vers DEL rouge de la carte Zybo
          o_pmodled   : out   std_logic_vector (7 downto 0);  -- vers connecteur pmod 8 DELs
          o_DEL2      : out   STD_LOGIC;
          i_S1        : in    STD_LOGIC :='0';
          i_S2        : in    STD_LOGIC :='0';
          i_ADC_th     : in    STD_LOGIC_VECTOR (11 downto 0) := "000000000000"
          );
end AppCombi_top;
 
architecture BEHAVIORAL of AppCombi_top is

   constant nbreboutons     : integer := 4;    -- Carte Zybo Z7
   constant freq_sys_MHz    : integer := 125;  -- 125 MHz 
   
   signal d_s_1Hz           : std_logic;
   signal clk_5MHz          : std_logic;
   --
   signal d_opa             : std_logic_vector (3 downto 0):= "0000";   -- operande A
   signal d_opb             : std_logic_vector (3 downto 0):= "0000";   -- operande B
   signal d_cin             : std_logic := '0';                         -- retenue entree
   signal d_sum             : std_logic_vector (3 downto 0):= "0000";   -- somme
   signal d_cout            : std_logic := '0';                         -- retenue sortie
   --
   signal d_AFF0            : std_logic_vector (3 downto 0):= "0000";
   signal d_AFF1            : std_logic_vector (3 downto 0):= "0000";
 
   
 component synchro_module_v2 is
   generic (const_CLK_syst_MHz: integer := freq_sys_MHz);
      Port ( 
           clkm        : in  STD_LOGIC;  -- Entrée  horloge maitre
           o_CLK_5MHz  : out STD_LOGIC;  -- horloge divise utilise pour le circuit             
           o_S_1Hz     : out  STD_LOGIC  -- Signal temoin 1 Hz
            );
      end component;  

   component septSegments_Top is
    Port (   clk          : in   STD_LOGIC;                      -- horloge systeme, typique 100 MHz (preciser par le constante)
             i_AFF0       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0
             i_AFF1       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0     
             o_AFFSSD_Sim : out string(1 to 2);
             o_AFFSSD     : out  STD_LOGIC_VECTOR (7 downto 0)  
           );
   end component;
   
   component Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           Ci : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC);
   end component;
   
   component Fct2_3 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
   end component;
   
   component Thermo2Bin is
    Port ( ADCth : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
   end component;
   
   component Bin2DualBCD is
    Port ( Unite_s : out STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           ADCbin : in STD_LOGIC_VECTOR (3 downto 0));
   end component;
   
   component Mux is
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
   end component;
   
   component Parite is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           S1 : in STD_LOGIC;
           Parite : out STD_LOGIC);
   end component;
   
   component decodeur3_8 is
    Port ( A2_3 : in STD_LOGIC_VECTOR (2 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0));
   end component;
   
   
   signal A2_3_temp : STD_LOGIC_VECTOR (2 downto 0);
   signal ADCbin_termo : STD_LOGIC_VECTOR (3 downto 0);
   signal Unite_s_temp : STD_LOGIC_VECTOR (3 downto 0);
   signal Code_signe_temp : STD_LOGIC_VECTOR (3 downto 0);
   signal Unites_ns_temp : STD_LOGIC_VECTOR (3 downto 0);
   signal Dizaines_temp : STD_LOGIC_VECTOR (3 downto 0);
   signal erreur_temp : STD_LOGIC;

begin
  
    inst_synch : synchro_module_v2
     generic map (const_CLK_syst_MHz => freq_sys_MHz)
         port map (
            clkm         => sysclk,
            o_CLK_5MHz   => clk_5MHz,
            o_S_1Hz      => d_S_1Hz
        );  

   inst_aff :  septSegments_Top 
       port map (
           clk    => clk_5MHz,
           -- donnee a afficher definies sur 8 bits : chiffre hexa position 1 et 0
           i_AFF1  => d_AFF1, 
           i_AFF0  => d_AFF0,
           o_AFFSSD_Sim   => open,   -- ne pas modifier le "open". Ligne pour simulations seulement.
           o_AFFSSD       => o_SSD   -- sorties directement adaptees au connecteur PmodSSD
       );
   
   inst_Add4bits : Add4bits
    port map ( 
            X => d_opa,
            Y => d_opb,
            Ci => d_cin,
            S => d_sum,
            Co => d_cout);
            
   inst_Fct2_3:Fct2_3
    port map (
        ADCbin => ADCbin_termo,
        A2_3 => A2_3_temp);
        
   inst_decodeur3_8:decodeur3_8
    port map (
        A2_3 => A2_3_temp,
        LED => o_pmodled);
        
   inst_Parite:Parite
    port map (
        ADCbin => ADCbin_termo,
        S1 => i_S1,
        Parite => o_DEL2);
        
   inst_Bin2DualBCD:Bin2DualBCD
    port map (
        ADCbin => ADCbin_termo,
        Unite_s => Unite_s_temp,
        Code_signe => Code_signe_temp,
        Unites_ns => Unites_ns_temp,
        Dizaines => Dizaines_temp);
        
   inst_mux:Mux
    port map (
        ADCbin => ADCbin_termo,
        Dizaines => Dizaines_temp,
        Unites_ns => Unites_ns_temp,
        Code_signe => Code_signe_temp,
        Unite_s => Unite_s_temp,
        erreur => erreur_temp,
        BTN(0) => i_btn(0),
        BTN(1) => i_btn(1),
        S2 => i_S2,
        DAFF0 => d_AFF0,
        DAFF1 => d_AFF1);
        
    inst_Thermo2Bin:Thermo2Bin
        port map (
            ADCth => i_ADC_th,
            ADCbin => ADCbin_termo,
            erreur => erreur_temp);
                   
                     
   d_opa               <=  i_sw;                        -- operande A sur interrupteurs
   d_opb               <=  i_btn;                       -- operande B sur boutons
   d_cin               <=  '0';                     -- la retenue d'entrée alterne 0 1 a 1 Hz
      
   d_AFF0              <=  d_sum(3 downto 0);           -- Le resultat de votre additionneur affiché sur PmodSSD(0)
   d_AFF1              <=  '0' & '0' & '0' & d_Cout;    -- La retenue de sortie affichée sur PmodSSD(1) (0 ou 1)
   o_led6_r            <=  d_Cout;                      -- La led couleur représente aussi la retenue en sortie  Cout
   o_pmodled           <=  d_opa & d_opb;               -- Les opérandes d'entrés reproduits combinés sur Pmod8LD
   o_led (3 downto 0)  <=  '0' & '0' & '0' & d_S_1Hz;   -- La LED0 sur la carte représente la retenue d'entrée        
   
   
end BEHAVIORAL;



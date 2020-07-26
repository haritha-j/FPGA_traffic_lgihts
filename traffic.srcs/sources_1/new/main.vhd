----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 09:01:51 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
    Port ( Reset : in STD_LOGIC;
           Sensor : in STD_LOGIC;
           Walk_request : in STD_LOGIC;
           Reprogram : in STD_LOGIC;
           selector : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           Clock : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (6 downto 0));
end main;

architecture Behavioral of main is

component synchronizer 
    Port ( reset : in STD_LOGIC;
           sensor : in STD_LOGIC;
           walk_request : in STD_LOGIC;
           reprogram : in STD_LOGIC;
           Prog_Sync : out STD_LOGIC;
           WR_Sync : out STD_LOGIC;
           Sensor_Sync : out STD_LOGIC;
           Reset_Sync : out STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

component fsm 
    Port ( sensor_sync : in STD_LOGIC;
           WR : in STD_LOGIC;
           WR_Reset : out STD_LOGIC;
           Prog_Sync : in STD_LOGIC;
           Interval : out STD_LOGIC_VECTOR (1 downto 0);
           start_timer : out STD_LOGIC;
           expired : in STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (6 downto 0);
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

component timer 
    Port ( enable : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR (3 downto 0);
           start_timer : in STD_LOGIC;
           reset_Sync : in STD_LOGIC;
           expired : out STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

component divider 
    Port ( Clock : in STD_LOGIC;
           enable : out STD_LOGIC;
           reset_Sync : in STD_LOGIC);
end component;

component time_params 
    Port ( selector : in STD_LOGIC_VECTOR (1 downto 0);
           Prog_Sync : in STD_LOGIC;
           interval : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           value : out STD_LOGIC_VECTOR (3 downto 0);
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

component walk_register
    Port ( WR_Sync : in STD_LOGIC;
           WR : out STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

SIGNAL sensor_sync : STD_LOGIC;
SIGNAL WR : STD_LOGIC;
SIGNAL WR_Reset : STD_LOGIC;
SIGNAL Prog_Sync : STD_LOGIC;
SIGNAL Interval : STD_LOGIC_VECTOR (1 downto 0);
SIGNAL start_timer : STD_LOGIC;
SIGNAL expired : STD_LOGIC;
SIGNAL Reset_Sync : STD_LOGIC;
SIGNAL WR_Sync : STD_LOGIC;
SIGNAL value : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL enable : STD_LOGIC;

begin

synchronizer1 :  synchronizer
    port map(  reset => Reset,
               sensor => Sensor,
               walk_request => Walk_request,
               reprogram => Reprogram,
               Prog_Sync => Prog_Sync,
               WR_Sync => WR_Sync,
               Sensor_Sync => sensor_sync,
               Reset_Sync => Reset_Sync,
               Clock => Clock);
    
walk_register1 : walk_register
    port map(  WR_Sync => WR_Sync,
               WR => WR,
               WR_Reset => WR_Reset,
               Reset_Sync => Reset_Sync,
               Clock => Clock);
               
fsm1 : fsm 
    port map(  sensor_sync => sensor_sync,
               WR => WR,
               WR_Reset => WR_Reset,
               Prog_Sync => Prog_Sync,
               Interval => Interval,
               start_timer => start_timer,
               expired => expired,
               LEDs => LED,
               Reset_Sync => Reset_Sync,
               Clock => Clock);
               
divider1 : divider
    port map(  Clock => Clock,
               enable => enable,
               reset_Sync => Reset_Sync);
        
time_params1 : time_params
    port map(  selector => selector,
               Prog_Sync => Prog_Sync,
               interval => Interval,
               time_value => time_value,
               value => value,
               Reset_Sync => Reset_Sync,
               Clock => Clock);
    
timer1 : timer 
    port map(  enable => enable,
           value => value,
           start_timer => start_timer,
           reset_Sync => Reset_Sync,
           expired => expired,
           Clock => Clock);
end Behavioral;

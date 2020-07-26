----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 10:57:43 PM
-- Design Name: 
-- Module Name: fsm_tb - Behavioral
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

entity fsm_tb is
--  Port ( );
end fsm_tb;

architecture Behavioral of fsm_tb is

component fsm is
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

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

SIGNAL sensor_sync : STD_LOGIC := '0';
SIGNAL WR : STD_LOGIC := '0';
SIGNAL WR_Reset : STD_LOGIC;
SIGNAL Prog_Sync : STD_LOGIC := '0';
SIGNAL Interval :  STD_LOGIC_VECTOR (1 downto 0);
SIGNAL start_timer : STD_LOGIC;
SIGNAL expired : STD_LOGIC := '0';
SIGNAL LEDs : STD_LOGIC_VECTOR (6 downto 0);
SIGNAL Reset_Sync : STD_LOGIC := '0';
SIGNAL Clock : STD_LOGIC := '0';

begin

test : fsm
port map(sensor_sync => sensor_sync,
WR => WR,
WR_Reset => WR_Reset,
Prog_Sync => Prog_Sync,
Interval => Interval,
start_timer => start_timer,
expired => expired,
LEDs => LEDs,
Reset_Sync => Reset_Sync,
Clock => Clock);

--start clock
Clock <= not Clock after ClockPeriod / 2;


stimuli : process
    begin
    wait for 100 ns;
    Reset_Sync <= '1';
    wait for 100 ns;
    Reset_Sync <= '0';
    wait for 50 ns;
    expired <= '1';
       wait for 50 ns;
    expired <= '0';
        wait for 50 ns;
    expired <= '1';
       wait for 50 ns;
    expired <= '0';
        wait for 50 ns;
    expired <= '1';
       wait for 50 ns;
    expired <= '0';
        wait for 50 ns;
    expired <= '1';
       wait for 50 ns;
    expired <= '0';
    
    wait;
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 10:39:36 PM
-- Design Name: 
-- Module Name: synchronizer_tb - Behavioral
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

entity synchronizer_tb is
--  Port ( );
end synchronizer_tb;

architecture Behavioral of synchronizer_tb is

component synchronizer is
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


constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

SIGNAL reset : STD_LOGIC := '0';
SIGNAL sensor : STD_LOGIC := '0';
SIGNAL walk_request : STD_LOGIC := '0';
SIGNAL reprogram : STD_LOGIC := '0';
SIGNAL Prog_Sync : STD_LOGIC;
SIGNAL WR_Sync : STD_LOGIC;
SIGNAL Sensor_Sync : STD_LOGIC;
SIGNAL Reset_Sync : STD_LOGIC;
SIGNAL Clock : STD_LOGIC := '0';

begin

test : synchronizer
port map( reset => reset,
sensor => sensor,
walk_request => walk_request,
reprogram => reprogram,
Prog_Sync => Prog_Sync,
WR_Sync => WR_Sync,
Sensor_Sync => Sensor_Sync,
Reset_Sync => Reset_Sync,
Clock => Clock);

--start clock
Clock <= not Clock after ClockPeriod / 2;

stimuli : process
    begin
    wait for 100 ns;
    Reset <= '1';
    wait for 100 ns;
    Reset <= '0';
    wait for 50 ns;
    sensor <= '1';
    wait for 50 ns;
    sensor <= '0';
    wait for 50 ns;
    walk_request <= '1';
    wait for 50 ns;
    walk_request <= '0';
    wait;
    end process;

end Behavioral;

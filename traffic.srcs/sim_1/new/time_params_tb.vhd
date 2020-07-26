----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 10:26:53 PM
-- Design Name: 
-- Module Name: time_params_tb - Behavioral
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

entity time_params_tb is
--  Port ( );
end time_params_tb;

architecture Behavioral of time_params_tb is

component time_params is
    Port ( selector : in STD_LOGIC_VECTOR (1 downto 0);
           Prog_Sync : in STD_LOGIC;
           interval : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           value : out STD_LOGIC_VECTOR (3 downto 0);
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

SIGNAL selector : STD_LOGIC_VECTOR (1 downto 0) := "00";
SIGNAL Prog_Sync : STD_LOGIC := '0';
SIGNAL interval : STD_LOGIC_VECTOR (1 downto 0) := "00";
SIGNAL time_value : STD_LOGIC_VECTOR (3 downto 0) := "0110";
SIGNAL value : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL Reset_Sync : STD_LOGIC := '0';
SIGNAL Clock : STD_LOGIC := '0';


begin

test : time_params
port map(selector => selector,
Prog_Sync => Prog_Sync,
interval => interval,
time_value => time_value,
value => value,
Reset_Sync => Reset_Sync,
Clock => Clock);

--start clock
Clock <= not Clock after ClockPeriod / 2;

stimuli : process
    --select and program a new value, then retrieve that value
    begin
    wait for 100 ns;
    Reset_Sync <= '1';
    wait for 100 ns;
    Reset_Sync <= '0';
    wait for 50 ns;
    selector <= "01";
    time_value <= "1111";
    Prog_Sync <= '1';
   wait for 15 ns;
   Prog_Sync <= '0';
   interval <= "01";
   --Sensor <= '0';
    wait;
    end process;

end Behavioral;

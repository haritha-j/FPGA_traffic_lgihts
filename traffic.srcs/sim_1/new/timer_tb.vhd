----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 07:22:31 PM
-- Design Name: 
-- Module Name: timer_tb - Behavioral
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

entity timer_tb is
--  Port ( );
end timer_tb;

architecture Behavioral of timer_tb is

component timer is
    Port ( enable : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR (3 downto 0);
           start_timer : in STD_LOGIC;
           reset_Sync : in STD_LOGIC;
           expired : out STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

SIGNAL enable : STD_LOGIC := '0';
SIGNAL value : STD_LOGIC_VECTOR (3 downto 0) := "0000";
SIGNAL start_timer : STD_LOGIC := '0';
SIGNAL reset_Sync : STD_LOGIC := '0';
SIGNAL expired : STD_LOGIC;
SIGNAL Clock : STD_LOGIC := '0';

constant enablePeriod    : time    := 1000 ms;

begin

test : timer
port map( enable => enable,
          value => value,
          start_timer => start_timer,
          reset_Sync => reset_Sync,
          expired => expired,
          Clock => Clock);

--start clock
Clock <= not Clock after ClockPeriod / 2;

enable <= not enable after enablePeriod / 2;
--test counting for 2 seconds
stimuli : process
    begin
    wait for 100 ns;
    reset_Sync <= '1';
    wait for 100 ns;
    reset_Sync <= '0';
    value <= "0010";
    wait for 100 ns;
    start_timer <= '1';
    wait for 100 ns;
    start_timer <= '0';
    wait;
    end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 07:22:31 PM
-- Design Name: 
-- Module Name: divider_tb - Behavioral
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

entity divider_tb is
--  Port ( );
end divider_tb;

architecture Behavioral of divider_tb is

component divider is
    Port ( Clock : in STD_LOGIC;
           enable : out STD_LOGIC;
           reset_Sync : in STD_LOGIC);
end component;

SIGNAL Clock : STD_LOGIC := '0';
SIGNAL enable : STD_LOGIC;
SIGNAL reset_Sync : STD_LOGIC := '0';

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

begin

test : divider
port map( enable => enable,
          Clock => Clock,
          reset_Sync => reset_Sync);

--start clock
Clock <= not Clock after ClockPeriod / 2;

stimuli : process
    begin
    wait for 100 ns;
    reset_Sync <= '1';
    wait for 100 ns;
    reset_Sync <= '0';
    wait;
    end process;
end Behavioral;

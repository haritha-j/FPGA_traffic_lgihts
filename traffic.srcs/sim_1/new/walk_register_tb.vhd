----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 09:14:09 PM
-- Design Name: 
-- Module Name: walk_register_tb - Behavioral
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

entity walk_register_tb is
--  Port ( );
end walk_register_tb;

architecture Behavioral of walk_register_tb is

component walk_register is
Port ( WR_Sync : in STD_LOGIC;
           WR : out STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end component;

SIGNAL WR_Sync : STD_LOGIC := '0';
SIGNAL WR : STD_LOGIC;
SIGNAL WR_Reset : STD_LOGIC := '0';
SIGNAL Reset_Sync : STD_LOGIC := '0';
SIGNAL Clock : STD_LOGIC := '0';

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

begin

test : walk_register
port map(  WR_Sync => WR_Sync,
WR => WR,
WR_Reset => WR_Reset,
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
    WR_Sync <= '1';
    wait for 10 ns;
    WR_Sync <= '0';
    wait for 1000 ns;
    WR_Reset <= '1';
   --Sensor <= '0';
    wait;
    end process;

end Behavioral;

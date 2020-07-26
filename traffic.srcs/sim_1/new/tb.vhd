----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 10:15:22 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component main
    Port ( Reset : in STD_LOGIC;
           Sensor : in STD_LOGIC;
           Walk_request : in STD_LOGIC;
           Reprogram : in STD_LOGIC;
           selector : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           Clock : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (6 downto 0));
end component;

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

SIGNAL Reset : STD_LOGIC := '0';
SIGNAL Sensor : STD_LOGIC := '0';
SIGNAL Walk_request : STD_LOGIC := '0';
SIGNAL Reprogram : STD_LOGIC := '0';
SIGNAL selector : STD_LOGIC_VECTOR (1 downto 0) := "00";
SIGNAL time_value : STD_LOGIC_VECTOR (3 downto 0) := "0000";
SIGNAL Clock : STD_LOGIC := '1';
SIGNAL LED : STD_LOGIC_VECTOR (6 downto 0);

begin

test : main
port map(  Reset =>  Reset,
           Sensor => Sensor,
           Walk_request => Walk_request, 
           Reprogram => Reprogram,
           selector => selector,
           time_value => time_value,
           Clock => Clock,
           LED => LED);

--start clock
Clock <= not Clock after ClockPeriod / 2;

stimuli : process
    begin
    wait for 100 ns;
    Reset <= '1';
    wait for 100 ns;
    Reset <= '0';
    wait for 50 ms;
    --Sensor <= '1';
    Walk_request <= '1';
   wait for 5 ms;
  Walk_request <= '0';
   --Sensor <= '0';
    wait;
    end process;

end Behavioral;

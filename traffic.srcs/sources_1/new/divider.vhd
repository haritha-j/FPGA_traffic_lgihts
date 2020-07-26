----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 06:49:46 PM
-- Design Name: 
-- Module Name: divider - Behavioral
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

entity divider is
    Port ( Clock : in STD_LOGIC;
           enable : out STD_LOGIC;
           reset_Sync : in STD_LOGIC);
end divider;

architecture Behavioral of divider is
--basys3 clock = 100mhz
--clock counter = 100 * 10^6 (2^27)
signal time : unsigned (26 downto 0);

begin

PROCESS(Clock, reset_sync)
BEGIN

if (reset_sync = '1') THEN
    time <= to_unsigned(100000, 27);
    enable <= '0';
end if;

if rising_edge(Clock) THEN
    if (time = to_unsigned(0, 27)) then
        enable <= '1';
        time <= to_unsigned(100000, 27);
    else
        time <= time - 1;
        enable <= '0';
    end if;
end if;

end process;
end Behavioral;

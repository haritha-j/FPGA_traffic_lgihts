----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 08:01:05 PM
-- Design Name: 
-- Module Name: time_params - Behavioral
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

entity time_params is
    Port ( selector : in STD_LOGIC_VECTOR (1 downto 0);
           Prog_Sync : in STD_LOGIC;
           interval : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           value : out STD_LOGIC_VECTOR (3 downto 0);
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end time_params;

architecture Behavioral of time_params is
SIGNAL param0 : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL param1 : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL param2 : STD_LOGIC_VECTOR(3 downto 0);

begin

PROCESS(Clock, reset_sync, selector, time_value, interval)
BEGIN

if (reset_sync = '1') THEN
    value <= "0110";
    param0 <= "0110";
    param1 <= "0011";
    param2 <= "0010";
end if;

--set new time values
if rising_edge(Clock) THEN
    if (Prog_Sync = '1') then
        if (selector = "00") then
            param0 <= time_value;
        elsif (selector = "01") then
            param1 <= time_value;
        elsif (selector = "10") then
            param2 <= time_value;
        end if;
    end if;
    
--select time value
    if (interval = "00") then
        value <= param0;
    elsif (interval = "01") then
        value <= param1;
    elsif (interval = "10") then
        value <= param2;
    end if;
    
end if;
end process;
end Behavioral;




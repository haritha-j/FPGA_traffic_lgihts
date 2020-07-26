----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 06:17:39 PM
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
    Port ( enable : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR (3 downto 0);
           start_timer : in STD_LOGIC;
           reset_Sync : in STD_LOGIC;
           expired : out STD_LOGIC;
           Clock : in STD_LOGIC);
end timer;

architecture Behavioral of timer is
SIGNAL time : unsigned (3 downto 0);
SIGNAL timer_ready : STD_LOGIC := '0';

begin
PROCESS(enable, value, start_timer,reset_Sync, Clock)
BEGIN

if rising_edge(Clock) THEN
 expired <='0';
if (reset_sync = '1') THEN
    time <= unsigned(value)-1;
    expired <= '0';
end if;


    if (start_timer = '1') then
        timer_ready <= '1';
        

         
    elsif (enable = '1') THEN
        if (timer_ready = '1') then
        time <= unsigned(value)-1;
        timer_ready <= '0';
        elsif (time = 1 ) then
            expired <= '1';
            time <= unsigned(value)-1;
        else
            time <= time -1;

        end if;
    end if;    
    
end if;
end process;
end Behavioral;

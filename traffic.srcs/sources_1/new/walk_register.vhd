----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2020 11:30:31 AM
-- Design Name: 
-- Module Name: walk_register - Behavioral
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

entity walk_register is
    Port ( WR_Sync : in STD_LOGIC;
           WR : out STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end walk_register;

architecture Behavioral of walk_register is
--SIGNAL walk : STD_LOGIC;

BEGIN

PROCESS(Clock, WR_Sync, WR_Reset, Reset_Sync)
BEGIN
if (reset_sync = '1') THEN
    WR <= '0';

elsif rising_edge(Clock) THEN
    if (WR_Sync = '1') THEN
        WR <= '1';
    END IF;
    
    if (WR_Reset = '1') THEN
        WR <= '0';
    END IF;
END IF;
END PROCESS;


end Behavioral;

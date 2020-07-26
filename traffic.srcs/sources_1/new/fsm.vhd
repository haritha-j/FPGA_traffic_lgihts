----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2020 09:21:34 AM
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
    Port ( sensor_sync : in STD_LOGIC;
           WR : in STD_LOGIC;
           WR_Reset : out STD_LOGIC;
           Prog_Sync : in STD_LOGIC;
           Interval : out STD_LOGIC_VECTOR (1 downto 0);
           start_timer : out STD_LOGIC;
           expired : in STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (6 downto 0);
           Reset_Sync : in STD_LOGIC;
           Clock : in STD_LOGIC);
end fsm;

--timer logic
--00 = tBASE
--01 = tEXT
--10 = tYEL
 
architecture Behavioral of fsm is

TYPE State_type IS (A, B, C, D, E);
SIGNAL State: State_Type;
SIGNAL timeExpiry : STD_LOGIC;
--add internal signal to check if tbase has epired once or twice
--change expired below to this signal
--LEDs - Rm, Ym, Gm,Rs, Ys, Gs, Walk 
begin

PROCESS (clock, sensor_sync, WR, Prog_Sync, expired, Reset_Sync)

BEGIN
if (reset_sync = '1') THEN
    State <= A;
    LEDs <= "0011000";
    Interval <= "00";
    timeExpiry <= '1';
    --start_timer <= '1';

ELSIF rising_edge(Clock) THEN
start_timer <= '0';
    CASE State IS
        
        WHEN A =>
         if (expired = '1') THEN
            if (timeExpiry = '0') THEN
                Interval <= "10";
                start_timer <= '1';
                timeExpiry <= '1';

                LEDs <= "0101000";
                State <= B;
            ELSE
                if (sensor_sync = '1') then
                    Interval <= "01";
                else
                    Interval <= "00";
                end if;
                timeExpiry <= '0';
                start_timer <= '1';
            END IF;
         ELSE
            start_timer <= '0';
         END IF;
         
        WHEN B =>
         IF (expired = '1') THEN
            if (WR = '1') THEN
                Interval <= "01";
                start_timer <= '1';
                LEDs <= "1001001";
                State <= E;
            ELSE
                Interval <= "00";
                start_timer <= '1';
                LEDs <= "1000010";
                State <= C;
            END IF;
         ELSE
            start_timer <= '0';           
         end if;
            
        WHEN C =>
         WR_Reset <= '0';
         IF (expired = '1') THEN
            IF (sensor_sync = '1') then
                Interval <= "01";
            else
                State <= D;
                Interval <= "10";
                LEDs <= "1000100";
            end if;
            start_timer <= '1';
         ELSE
            start_timer <= '0';
         END IF;
            
        WHEN D => 
         IF (expired = '1') THEN
            Interval <= "00";
            start_timer <= '1';
            LEDs <= "0011000";
            State <= A;
         ELSE
            start_timer <= '0';
         END IF;
         
        WHEN E =>
         IF (expired = '1') then
            Interval <= "00";
            start_timer <= '1';
            LEDs <= "1000010";
            WR_Reset <= '1';
            State <= C;
         ELSE
            start_timer <= '0';
         end if;

    END CASE;
            
END IF;
END PROCESS;
end Behavioral;

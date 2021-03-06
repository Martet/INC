-- uart_fsm.vhd: UART controller - finite state machine
-- Author(s): Martin Zmitko <xzmitk01@stud.fit.vutbr.cz>
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-------------------------------------------------
entity UART_FSM is
port(
   CLK       : in std_logic;
   RST       : in std_logic;
   DIN       : in std_logic;
   CNT_START : in std_logic_vector(4 downto 0);
   CNT_DATA  : in std_logic_vector(3 downto 0);
   RD_EN     : out std_logic;
   CNT_EN    : out std_logic;
   CFM       : out std_logic
   );
end entity UART_FSM;

-------------------------------------------------
architecture behavioral of UART_FSM is
type STATE_TYPE is (WAITING, WAIT_FIRST, DATA, WAIT_LAST, CONFIRM);
signal STATE : STATE_TYPE := WAITING;
signal LAST_CONFIRM : std_logic := '0';
begin

RD_EN <= '1' when STATE = DATA else '0';
CNT_EN <= '0' when STATE = WAITING or STATE = CONFIRM else '1'; 

process (CLK) begin
   if rising_edge(CLK) then
      if RST = '1' then
         STATE <= WAITING;
      else
         case STATE is
            when WAITING => if DIN = '0' then
               STATE <= WAIT_FIRST;
               end if;
            when WAIT_FIRST => if CNT_START(4) = '1' then
               STATE <= DATA;
               end if;
            when DATA => if CNT_DATA(3) = '1' then
               STATE <= WAIT_LAST;
               end if;
            when WAIT_LAST => if DIN = '1' then
               STATE <= CONFIRM;
               end if;
            when CONFIRM => if LAST_CONFIRM = '0' then
                  LAST_CONFIRM <= '1';
                  CFM <= '1';
               else
                  LAST_CONFIRM <= '0';
                  CFM <= '0';
                  STATE <= WAITING;
               end if;
            when others => null;
         end case;
      end if;
   end if;
end process;
end behavioral;

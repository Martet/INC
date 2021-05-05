-- uart_fsm.vhd: UART controller - finite state machine
-- Author(s): Martin Zmitko <xzmitk01@stud.fit.vutbr.cz>
--
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------
entity UART_FSM is
port(
   CLK       : in std_logic;
   RST       : in std_logic;
   DIN       : in std_logic;
   CNT_START : in std_logic_vector(4 downto 0);
   CNT_DATA  : in std_logic_vector(3 downto 0);
   RD_EN     : out std_logic
   );
end entity UART_FSM;

-------------------------------------------------
architecture behavioral of UART_FSM is
type STATE_TYPE is (WAITING, WAIT_FIRST, DATA, WAIT_LAST, CONFIRM);
signal STATE : STATE_TYPE := WAITING;
signal LAST_CONFIRM : std_logic := '0';
begin
process (CLK) begin
   if rising_edge(CLK) then
      if RST = '1' then
         STATE <= WAITING;
      else
         case STATE is
            when WAITING => if DIN = '0' then
               STATE <= WAIT_FIRST;
               end if;
            when WAIT_FIRST => if CNT_START = "11000" then
               STATE <= DATA;
               end if;
            when DATA => if CNT_DATA = "1000" then
               STATE <= WAIT_LAST;
               end if;
            when WAIT_LAST => if DIN = '0' then
               STATE <= CONFIRM;
               end if;
            when CONFIRM => if LAST_CONFIRM = '0' then
                  LAST_CONFIRM <= '1';
               else
                  LAST_CONFIRM <= '0';
                  STATE <= WAITING;
               end if;
         end case;
      end if;
   end if;
end process;
end behavioral;

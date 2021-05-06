-- uart.vhd: UART controller - receiving part
-- Author(s): Martin Zmitko <xzmitk01@stud.fit.vutbr.cz>
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-------------------------------------------------
entity UART_RX is
port(
    CLK:        in std_logic;
    RST:        in std_logic;
    DIN:        in std_logic;
    DOUT:       out std_logic_vector(7 downto 0);
    DOUT_VLD:   out std_logic
);
end UART_RX;

-------------------------------------------------
architecture behavioral of UART_RX is

signal cnt_start : std_logic_vector(4 downto 0) := "00000";
signal cnt_data  : std_logic_vector(3 downto 0) := "0000";
signal rd_en     : std_logic;
signal cnt_en    : std_logic;
signal cfm       : std_logic;

begin
FSM: entity work.UART_FSM(behavioral)
port map (
    CLK       => CLK,
    RST       => RST,
    DIN       => DIN,
    CNT_START => cnt_start,
    CNT_DATA  => cnt_data,
    RD_EN     => rd_en,
    CNT_EN    => cnt_en,
    CFM       => cfm
);

DOUT_VLD <= cfm;

process (CLK) begin
    --report std_logic'image(cnt_en) & std_logic'image(rd_en);
    if rising_edge(CLK)  then
        if cnt_en = '1' then
            cnt_start <= cnt_start + 1;
            if rd_en = '0' and cnt_start = "00110" then
                cnt_start <= "10000";
            end if;
            if rd_en = '1' and cnt_start(4) = '1' then
                cnt_start <= "00010";
            end if;
            --report integer'image(to_integer(unsigned(cnt_start)));
        else
            cnt_start <= "00000";
        end if;
        if rd_en = '1' then
            if cnt_start = "01111" then
                DOUT(to_integer(unsigned(cnt_data))) <= DIN;
                cnt_start <= "00000";
                cnt_data <= cnt_data + 1;
            end if;
        else
            cnt_data <= "0000";
        end if;
    end if;
end process;
end behavioral;

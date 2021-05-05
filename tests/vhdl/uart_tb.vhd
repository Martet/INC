library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity testbench is
end testbench;

---------------------------------------------------------------
architecture TB of testbench is

    constant baudrate : natural := 9600;
    constant clkrate : natural := baudrate*16;
    constant clk_period : time := 1 sec / clkrate;
    constant baud_period : time := clk_period*16;

    signal clk:       std_logic;
    signal rst: 	    std_logic;
    signal din: 	    std_logic;
    signal dout: 	    std_logic_vector(7 downto 0);
    signal dout_vld: 	std_logic;

    -- Auxilary procedure for byte sending
    procedure send_byte(constant byte_in  : in  std_logic_vector(7 downto 0);
                        signal din  : out std_logic) is
        begin
            din <= '0';
            wait for baud_period;
            for i in 0 to 7 loop
                din <= byte_in(i);
                wait for baud_period;
            end loop;
            din <= '1';
            wait for baud_period;
    end send_byte;

begin
    -- Design under test
    DUT: entity work.UART_RX(behavioral)
    port map (
        CLK 	    => clk,
        RST 	    => rst,
        DIN 	    => din,
        DOUT 	    => dout,
        DOUT_VLD 	=> dout_vld
    );
    
    out_write : process(clk, rst)
        file output		: text open write_mode is "output.txt";
        variable row	: line;
		begin
        if (rst = '1') then
				elsif (rising_edge(clk)) then
				    if (dout_vld = '1') then
				        write(row, dout, right, 8);
				  		  writeline(output, row);
				    end if;
				end if; 
    end process;
    
    in_read : process
        file input		: text open read_mode is "input.txt";
        variable row	: line;
        variable val  : std_logic_vector(7 downto 0);
		begin
        rst <= '1';
        din <= '1';
        wait for clk_period*5;
        rst <= '0';
        wait for clk_period*5;
        
        while not endfile(input) loop
            readline(input, row);
            read(row, val);
            send_byte(val, din);
            wait for baud_period;
				end loop;
        
				wait;
    end process;

    -- Clock generator
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

end TB;
-----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_tb is
end clock_tb;

architecture testbench of clock_tb is
	
	constant c_CLOCK_PERIOD : time := 20 ns; --50MHz
	
	signal r_clock : std_logic := '0';
	signal w_1Hz	: std_logic;
	signal w_1kHz	: std_logic;
	signal w_1MHz	: std_logic;
	
	component clock is
		port(
			  i_50MHz	: in  std_logic;
			  o_1Hz		: out std_logic;
			  o_1kHz		: out std_logic;
			  o_1MHz		: out std_logic 
			 );
	end component;
	
begin

	clock_Comp : clock
	port map(
				i_50MHz	=> r_clock,
				o_1Hz		=> w_1Hz,
				o_1kHz	=> w_1kHz,
				o_1MHz	=> w_1MHz
			  );

	process
	begin
		wait for c_CLOCK_PERIOD/2;
		r_clock <= not r_clock;
	end process;
	
	process
	begin
		wait for 1 sec;
	end process;
	
end testbench;
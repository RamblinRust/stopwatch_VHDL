--1KHz clock

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_1K is 
	port(
			i_50MHz	: in	std_logic;
			o_1KHz	: out	std_logic
		 );
end entity;

architecture divider of clock_1K is
	constant divisor	: integer := 25000;
	signal divide_by	: integer := 0;
	signal r_divided_clock : std_logic := '0';
begin

	process (i_50MHz)
	begin
		if rising_edge(i_50MHz) then
			r_divided_clock <= r_divided_clock;
			divide_by <= divide_by + 1;
			if(divide_by = divisor-1) then
				divide_by <= 0;
				r_divided_clock <= not(r_divided_clock);
			end if;
		end if;
	end process;

	o_1KHz <= r_divided_clock;
	
end divider;
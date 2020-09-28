--takes an input frequency clock and divides
--it into some frequencies

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
	port(
		  i_50MHz	: in  std_logic;--takes a 50MHz frequency input
		  o_1Hz		: out std_logic;--outputs a 1 Hz frequency
		  o_1kHz		: out std_logic;--outputs a 1 kHz frequency
		  o_1MHz		: out std_logic --outputs a 1 MHz frequency
		 );
end clock;

architecture divider of clock is
	signal r_1MHz, r_1MHz_next : std_logic := '0';
	signal r_1kHz, r_1kHz_next : std_logic := '0';
	signal r_1Hz, r_1Hz_next : std_logic := '0';
	signal r_50_cntr, r_50_cntr_next : unsigned(5 downto 0) := to_unsigned(0,6);
	signal r_1000_cntr0, r_1000_cntr1 : unsigned(9 downto 0) := to_unsigned(0,10);
	signal r_1000_cntr0_next, r_1000_cntr1_next : unsigned(9 downto 0) := to_unsigned(0,10);
begin
	
	process (i_50MHz)
	begin
		--update values
		if rising_edge(i_50MHz) then
			r_50_cntr <= r_50_cntr_next;
			r_1000_cntr0 <= r_1000_cntr0_next;
			r_1000_cntr1 <= r_1000_cntr1_next;
			r_1MHz <= r_1MHz_next;
			r_1kHz <= r_1kHz_next;
			r_1Hz <= r_1Hz_next;
		end if;
	end process;
	
	--not right yet. double latch
	process (i_50MHz, r_1MHz, r_1kHz,r_1Hz, r_50_cntr, r_1000_cntr0, r_1000_cntr1)
	begin
		--defaults
		r_1MHz_next <= r_1MHz;
		r_1kHz_next <= r_1kHz;
		r_1Hz_next <= r_1Hz;
		r_50_cntr_next <= r_50_cntr_next;
		r_1000_cntr0_next <= r_1000_cntr0_next;
		r_1000_cntr1_next <= r_1000_cntr1_next;
		
		if (i_50MHz = '0') then
			--r_1MHz_next <= r_1MHz;
			r_50_cntr_next <= r_50_cntr + 1;
			if(r_50_cntr = to_unsigned(49,6)) then
				r_50_cntr_next <= to_unsigned(0,6);
				r_1MHz_next <= not(r_1MHz);
			end if;
		end if;
		
		if (r_1MHz = '0') then
			--r_1kHz_next <= r_1kHz;
			r_1000_cntr0_next <= r_1000_cntr0 + 1;
			if(r_1000_cntr0 = to_unsigned(999,10)) then
				r_1000_cntr0_next <= to_unsigned(0,10);
				r_1kHz_next <= not(r_1kHz);
			end if;
		end if;
		
		if (r_1kHz = '0') then
			--r_1Hz_next <= r_1Hz;
			r_1000_cntr1_next <= r_1000_cntr1 + 1;
			if(r_1000_cntr1 = to_unsigned(999,10)) then
				r_1000_cntr1_next <= to_unsigned(0,10);
				r_1Hz_next <= not(r_1Hz);
			end if;
		end if;
		
	end process;
	
	o_1Hz <= r_1Hz;
	o_1kHz <= r_1kHz;
	o_1MHz <= r_1MHz;
	
end divider;
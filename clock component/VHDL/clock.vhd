--takes an input frequency clock and divides
--it into some frequencies

library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(
		  i_50MHz	: in  std_logic;--takes a 50MHz frequency input
		  o_1Hz		: out std_logic;--outputs a 1 Hz frequency
		  o_1kHz		: out std_logic;--outputs a 1 kHz frequency
		  o_1MHz		: out std_logic --outputs a 1 MHz frequency
		 );
end clock;

architecture divider of clock is
	signal r_1MHz, r_1kHz : std_logic;
begin
	
	
	
end divider;
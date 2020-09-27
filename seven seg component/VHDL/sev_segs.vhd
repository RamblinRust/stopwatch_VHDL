--7 seg component
--takes 4 bits and outputs the
--corresponding hex value on 
--a seven seg.
library ieee;
use ieee.std_logic_1164.all;

entity sev_segs is
	port(
		i_number	: in  std_logic_vector(3 downto 0);
		--i_dp		: in 	std_logic;
		o_top		: out std_logic;--bit 0
		o_rtop	: out std_logic;--1
		o_rbot	: out std_logic;--2
		o_bot		: out std_logic;--3
		o_lbot	: out std_logic;--4
		o_ltop	: out std_logic;--5
		o_mid		: out std_logic--6
		--can't find the decimal point in the de-10 manual,
		--so I'm removing this output
		--o_dp		: out std_logic
		);
end sev_segs;

architecture decoder of sev_segs is
	signal w_segments : std_logic_vector(6 downto 0);
begin

	with i_number select
		w_segments <=  "0111111" when "0000",--0
							"0000110" when "0001",--1
							"1011011" when "0010",--2
							"1001111" when "0011",--3
							"1100110" when "0100",--4
							"1101101" when "0101",--5
							"1111101" when "0110",--6
							"0000111" when "0111",--7
							"1111111" when "1000",--8
							"1100111" when "1001",--9
							"1110111" when "1010",--A
							"1111100" when "1011",--b
							"0111001" when "1100",--C
							"1011110" when "1101",--d
							"1111001" when "1110",--E
							"1110001" when "1111",--f							
						 	"0000000" when others;

	o_top  <= w_segments(0);						
	o_rtop <= w_segments(1);
	o_rbot <= w_segments(2);
	o_bot	 <= w_segments(3);
	o_lbot <= w_segments(4);
	o_ltop <= w_segments(5);
	o_mid	 <= w_segments(6);
	--o_dp	<= i_dp;
end decoder;
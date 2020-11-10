--General counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_Counter is
	Generic(
				N : in natural := 4
			);
	port(
			i_clk, i_en, i_ld, i_up, i_clr : in std_logic;
			i_ldVal	: in std_logic_vector(N-1 downto 0);
			o_co		: out std_logic;
			o_cnt 	: out std_logic_vector(N-1 downto 0)
		);
end gen_Counter;

architecture counter of gen_Counter is

	signal w_inputs : std_logic_vector(2 downto 0);
	signal w_nxt_cnt, r_cur_cnt: unsigned(N-1 downto 0) := to_unsigned(0,N);
	
begin
	
	w_inputs <= i_ld & i_up & i_en; --put the control inputs into a vector for a when else
	
	--on the clock, update the output value
	process (i_clk, i_clr)
	begin
		r_cur_cnt <= r_cur_cnt;
		
		if(i_clr = '1') then
			r_cur_cnt <= to_unsigned(0,r_cur_cnt'length);
		elsif(rising_edge(i_clk)) then
			r_cur_cnt <= w_nxt_cnt;
		end if;
	end process;
	
	--select the next value based on the control inputs
	with w_inputs select w_nxt_cnt <=
		r_cur_cnt when "000", "010", "100", "110",
		r_cur_cnt-1 when "001",
		r_cur_cnt+1 when "011",
		unsigned(i_ldval) when "101","111",
		(others => '0') when others;
		
	o_co <= '1' when std_logic_vector(r_cur_cnt) = (others => '1') else '0';	
	o_cnt <= std_logic_vector(r_cur_cnt);
	
end counter;
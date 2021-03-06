library ieee;
use ieee.std_logic_1164.all;

entity modCounter_tb is
end modCounter_tb;

architecture tb of modCounter_tb is

	constant c_CLOCK_PERIOD : time := 20 ns; --50MHz
	
	signal r_clock : std_logic := '0';
	signal w_en, w_clr : std_logic := '0';
	signal w_num, w_num2 : std_logic_vector(3 downto 0) := (others => '0');
	signal w_co, w_co2	: std_logic := '0';

	component modCounter is
	port(
			i_clk : in std_logic;--clock
			i_en	: in std_logic;--enable 
			i_clr	: in std_logic; --clear
			o_num	: out std_logic_vector(3 downto 0); --number out
			o_co	: out std_logic --carry out
		 );
	end component;

begin

	testCounter : modCounter
	port map(
			i_clk => r_clock,--clock
			i_en	=> w_en,--enable 
			i_clr	=> w_clr, --clear
			o_num	=> w_num, --number out
			o_co	=> w_co --carry out
		 );

	testCounter2 : modCounter
	port map(
			i_clk => r_clock,--clock
			i_en	=> w_co,--enable 
			i_clr	=> w_clr, --clear
			o_num	=> w_num2, --number out
			o_co	=> w_co2 --carry out
		 );
	
	process
	begin
		wait for c_CLOCK_PERIOD/2;
		r_clock <= not r_clock;
	end process;
	
	process
	begin
		
		w_en <= '1'; --enable pin
		wait for 240 ns;
		W_clr <= '1';
		wait for 40 ns;
		w_en <= '0';
		w_clr <= '0';
		wait for 20 ns;
		
	end process;
	
end tb;
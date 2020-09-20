--not finished

--A stopwatch that will measure to 1/100 s
--will have a start/stop button

library ieee;
use ieee.std_logic_1164.all;

entity stop_watch is
	port(
		  i_50MHz : in std_logic;--50MHz crystal from board
		  i_st	 : in std_logic;--start/stop button
		  i_clr	 : in std_logic;--clear button
		  o_top0, o_rtop0, o_rbot0, o_bot0, o_lbot0, o_ltop0, o_mid0, o_dp0 : out std_logic; --output pins for 7seg 0
		  o_top1, o_rtop1, o_rbot1, o_bot1, o_lbot1, o_ltop1, o_mid1, o_dp1 : out std_logic; --output pins for 7seg 1
		  o_top2, o_rtop2, o_rbot2, o_bot2, o_lbot2, o_ltop2, o_mid2, o_dp2 : out std_logic; --output pins for 7seg 2
		  o_top3, o_rtop3, o_rbot3, o_bot3, o_lbot3, o_ltop3, o_mid3, o_dp3 : out std_logic; --output pins for 7seg 3
		  o_top4, o_rtop4, o_rbot4, o_bot4, o_lbot4, o_ltop4, o_mid4, o_dp4 : out std_logic  --output pins for 7seg 4
		 );
end stop_watch;

architecture watch of stop_watch is
	signal w_clock 									: std_logic;
	signal r_started									: std_logic := '0';
	signal r_thousandths, r_thousandths_next	: std_logic_vector(3 downto 0) := (others => '0');--curr and next 1/1000
	signal r_hundredths, r_hundredths_next		: std_logic_vector(3 downto 0) := (others => '0');--curr and next 1/100
	signal r_tenths, r_tenths_next	   		: std_logic_vector(3 downto 0) := (others => '0');--curr and next 1/10
	signal r_ones, r_ones_next						: std_logic_vector(3 downto 0) := (others => '0');--curr and next 1
	signal r_tens, r_tens_next						: std_logic_vector(3 downto 0) := (others => '0');--curr and next 10
begin
	
	--clock instance declaration
	clock_inst : clock
		port map(
					i_50MHz	=> i_50MHz,
					o_1Hz		=> open,
					o_1kHz	=> w_clock,
					o_1MHz	=> open
				  );
				  
	--seven segment instance declarations			  
	sev_seg0 : sev_segs
		port map(
					i_number	=> r_thousandths,
					i_dp		=> '0',
					o_top		=> o_top0,
					o_rtop	=> o_rtop0,
					o_rbot	=> o_rbot0,
					o_bot		=> o_bot0,
					o_lbot	=> o_lbot0,
					o_ltop	=> o_ltop0,
					o_mid		=> o_mid0,
					o_dp		=> o_dp0
				  );
				  
	sev_seg1 : sev_segs
		port map(
					i_number	=> r_hundredths,
					i_dp		=> '0',
					o_top		=> o_top1,
					o_rtop	=> o_rtop1,
					o_rbot	=> o_rbot1,
					o_bot		=> o_bot1,
					o_lbot	=> o_lbot1,
					o_ltop	=> o_ltop1,
					o_mid		=> o_mid1,
					o_dp		=> o_dp1
				  );
				  
	sev_seg2 : sev_segs
		port map(
					i_number	=> r_tenths,
					i_dp		=> '0',
					o_top		=> o_top2,
					o_rtop	=> o_rtop2,
					o_rbot	=> o_rbot2,
					o_bot		=> o_bot2,
					o_lbot	=> o_lbot2,
					o_ltop	=> o_ltop2,
					o_mid		=> o_mid2,
					o_dp		=> o_dp2
				  );
	
	sev_seg3 : sev_segs
		port map(
					i_number	=> r_ones,
					i_dp		=> '1',
					o_top		=> o_top3,
					o_rtop	=> o_rtop3,
					o_rbot	=> o_rbot3,
					o_bot		=> o_bot3,
					o_lbot	=> o_lbot3,
					o_ltop	=> o_ltop3,
					o_mid		=> o_mid3,
					o_dp		=> o_dp3
				  );
	
	sev_seg4 : sev_segs
		port map(
					i_number	=> r_tens,
					i_dp		=> '0',
					o_top		=> o_top4,
					o_rtop	=> o_rtop4,
					o_rbot	=> o_rbot4,
					o_bot		=> o_bot4,
					o_lbot	=> o_lbot4,
					o_ltop	=> o_ltop4,
					o_mid		=> o_mid4,
					o_dp		=> o_dp4
				  );
	--end seven seg declarations
	
	--was having issue deciding when the time should start counting
	--will have up to a 1ms error 
	process(w_clock, r_started, i_cl)
	begin
		--defaults
		r_thousandths	<= r_thousandths;
		r_hundredths	<= r_hundredths;
		r_tenths			<= r_tenths;
		r_ones			<= r_ones;
		r_tens		 	<= t_tens;
		
		--if cleared or started
		if(i_cl) then
			r_thousandths	<= (others => '0');
			r_hundredths	<= (others => '0');
			r_tenths			<= (others => '0');
			r_ones			<= (others => '0');
			r_tens		 	<= (others => '0');
--		elsif(i_st) then
--			if(r_started = '0') then r_started <= '1';
--			else r_started = '0';
		elsif(r_started = '1') then
			r_thousandths	<= r_thousandths_next;
			r_hundredths	<= r_hundredths_next;
			r_tenths			<= r_tenths_next;
			r_ones			<= r_ones_next;
			r_tens		 	<= t_tens_next;
		end if;
	end process
	
	process(r_thousandths)
	begin
		r_thousandths_next <= r_thousandths + 1;
		if(r_thousands = 
	
end watch;
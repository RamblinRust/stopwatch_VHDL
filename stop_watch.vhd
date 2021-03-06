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
		  o_top0, o_rtop0, o_rbot0, o_bot0, o_lbot0, o_ltop0, o_mid0: out std_logic; --output pins for 7seg 0
		  o_top1, o_rtop1, o_rbot1, o_bot1, o_lbot1, o_ltop1, o_mid1: out std_logic; --output pins for 7seg 1
		  o_top2, o_rtop2, o_rbot2, o_bot2, o_lbot2, o_ltop2, o_mid2: out std_logic; --output pins for 7seg 2
		  o_top3, o_rtop3, o_rbot3, o_bot3, o_lbot3, o_ltop3, o_mid3: out std_logic; --output pins for 7seg 3
		  o_top4, o_rtop4, o_rbot4, o_bot4, o_lbot4, o_ltop4, o_mid4: out std_logic  --output pins for 7seg 4
		 );
end stop_watch;

architecture watch of stop_watch is
	
	component clock_1k is
		port(
			  i_50MHz	: in  std_logic;
			  o_1kHz		: out std_logic
			 );
	end component;
	
	component sev_segs is
		port(
			i_number	: in  std_logic_vector(3 downto 0);
			o_top		: out std_logic;
			o_rtop	: out std_logic;
			o_rbot	: out std_logic;
			o_bot		: out std_logic;
			o_lbot	: out std_logic;
			o_ltop	: out std_logic;
			o_mid		: out std_logic
			);
	end component;
	
--	component modCounter is
--		port(
--				i_clk : in std_logic;--clock
--				i_en	: in std_logic;--enable
--				i_clr	: in std_logic; --clear
--				o_num	: out std_logic_vector(3 downto 0); --number out
--				o_co	: out std_logic --carry out
--			 );
--	end component;
	
	component gen_Counter is
		generic(N : in natural := 4);
		port(
			i_clk, i_en, i_ld, i_up, i_clr : in std_logic;
			i_ldVal	: in std_logic_vector(N-1 downto 0);
			o_co		: out std_logic;
			o_cnt 	: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	signal w_clk 		: std_logic := '0';
	signal w_co0, w_co1, w_co2, w_co3 : std_logic := '0';
	signal r_started		: std_logic := '0';
	signal r_thousandths	: std_logic_vector(3 downto 0) := (others => '0');--curr 1/1000
	signal r_hundredths	: std_logic_vector(3 downto 0) := (others => '0');--curr 1/100
	signal r_tenths		: std_logic_vector(3 downto 0) := (others => '0');--curr 1/10
	signal r_ones			: std_logic_vector(3 downto 0) := (others => '0');--curr 1
	signal r_tens			: std_logic_vector(3 downto 0) := (others => '0');--curr 10
begin
	
	--clock instance declaration
	clock_inst : clock_1k
		port map(
					i_50MHz	=> i_50MHz,
					o_1kHz	=> w_clk
				  );
	--end clock declaration
	
	--seven segment instance declarations			  
	sev_seg0 : sev_segs
		port map(
					i_number	=> r_thousandths,
					o_top		=> o_top0,
					o_rtop	=> o_rtop0,
					o_rbot	=> o_rbot0,
					o_bot		=> o_bot0,
					o_lbot	=> o_lbot0,
					o_ltop	=> o_ltop0,
					o_mid		=> o_mid0
				  );
				  
	sev_seg1 : sev_segs
		port map(
					i_number	=> r_hundredths,
					o_top		=> o_top1,
					o_rtop	=> o_rtop1,
					o_rbot	=> o_rbot1,
					o_bot		=> o_bot1,
					o_lbot	=> o_lbot1,
					o_ltop	=> o_ltop1,
					o_mid		=> o_mid1
				  );
				  
	sev_seg2 : sev_segs
		port map(
					i_number	=> r_tenths,
					o_top		=> o_top2,
					o_rtop	=> o_rtop2,
					o_rbot	=> o_rbot2,
					o_bot		=> o_bot2,
					o_lbot	=> o_lbot2,
					o_ltop	=> o_ltop2,
					o_mid		=> o_mid2
				  );
	
	sev_seg3 : sev_segs
		port map(
					i_number	=> r_ones,
					o_top		=> o_top3,
					o_rtop	=> o_rtop3,
					o_rbot	=> o_rbot3,
					o_bot		=> o_bot3,
					o_lbot	=> o_lbot3,
					o_ltop	=> o_ltop3,
					o_mid		=> o_mid3
				  );
	
	sev_seg4 : sev_segs
		port map(
					i_number	=> r_tens,
					o_top		=> o_top4,
					o_rtop	=> o_rtop4,
					o_rbot	=> o_rbot4,
					o_bot		=> o_bot4,
					o_lbot	=> o_lbot4,
					o_ltop	=> o_ltop4,
					o_mid		=> o_mid4
				  );
	--end seven seg declarations
	
	--mod 10 declarations
	--the clears are nots because the button is active low...
	mod10_0 : modCounter --thousandths place (milliseconds)
		port map(
					i_clk => w_clk, --the 1KHz clock
					i_en => r_started,
					i_clr => not(i_clr), --clear the mod counter (the not is because button is active-low)
					o_num => r_thousandths, --the 4-bit output of the modcounter which is connected to the Thousandths place seven seg
					o_co => w_co0 --carry-out, used to clock hundredths place
				  );
				  
	mod10_1 : modCounter --hundredths place
		port map(
					i_clk => not(w_co0), --clocked by the falling edge of the carry-out of the thousandths place
					i_en => r_started,
					i_clr => not(i_clr),
					o_num => r_hundredths, --the 4-bit output of the modcounter which is connected to the Hundredths place seven seg
					o_co => w_co1 --carry-out, used to clock tenths place
				  );
				  
	mod10_2 : modCounter --tenths place
		port map(
					i_clk => not(w_co1), --clocked by the falling edge of the carry-out of the hundredths place
					i_en => r_started,
					i_clr => not(i_clr), 
					o_num => r_tenths, --the 4-bit output of the modcounter which is connected to the tenths place seven seg
					o_co => w_co2 --carry-out, used to clock ones place
				  );
	
	mod10_3 : modCounter --ones place (seconds)
		port map(
					i_clk => not(w_co2), --clocked by the falling edge of the carry-out of the tenths place
					i_en => r_started,
					i_clr => not(i_clr),
					o_num => r_ones, --the 4-bit output of the modcounter which is connected to the ones place seven seg
					o_co => w_co3 --carry-out, used to clock tenss place
				  );
				  
	mod10_4 : modCounter --tens place
		port map(
					i_clk => not(w_co3), --clocked by the falling edge of the carry-out of the ones place
					i_en => r_started,
					i_clr => not(i_clr),
					o_num => r_tens, --the 4-bit output of the modcounter which is connected to the tens place seven seg
					o_co => open --left open because there is no higher second recorded
				  );
	--end mod 10 declarations
	
	--latches and unlatches the start
	process(i_st)
	begin
		if rising_edge(i_st) then
			r_started <= not(r_started);
		end if;
	end process;
	
end watch;
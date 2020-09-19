--Not finished

--A stopwatch that will measure to 1/100 s
--will have a start/stop button

library ieee;
use ieee.std_logic_1164.all;

entity stop_watch is
	port(
		  i_50MHz : in std_logic;--50MHz crystal from board
		  i_st	 : in std_logic;--start/stop button
		  
		 );
end stop_watch;

architecture watch of stop_watch is
	
begin
	
end watch;

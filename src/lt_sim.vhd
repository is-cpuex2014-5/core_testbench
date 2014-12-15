library  ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity lt_sim is  
  port (
    Q : out std_logic);
end entity lt_sim;

architecture lt_sim of lt_sim is

  component compr is
    port (
      clk       : in  std_logic;
      opc_compr : in  std_logic_vector(6 downto 0);
      reg_in_a  : in  std_logic_vector(31 downto 0);
      reg_in_b  : in  std_logic_vector(31 downto 0);
      cond_out  : out std_logic);
  end component compr;

  signal a : std_logic_vector (31 downto 0) := (others => '0');
  signal b : std_logic_vector (31 downto 0) := (others => '0');
  signal c : std_logic := '0';  
  signal clk : std_logic := '0';

  type buff is array (3 downto 0) of std_logic_vector (31 downto 0);
  signal cc : buff := (others => (others => '0'));
  signal cccc : std_logic := '0';
  signal tmpc : std_logic := '0';  
  signal state : std_logic_vector (1 downto 0) := (others => '0');
  signal s : std_logic := '0';
  constant clk_period : time := 10 ns;
  constant opcode : std_logic_vector (6 downto 0) := "1000010";
  file inf : text;
begin  -- architecture lt_sim

  file_open(inf, "lt.dat",  read_mode);
  i_compr : compr port map (clk,opcode,a,b,c);

  main_loop: process 
    variable l : line;
    variable aa : std_logic_vector (31 downto 0) := (others => '0');
    variable bb : std_logic_vector (31 downto 0) := (others => '0');
    variable cc : std_logic := '0'; 
    variable ss : character;
    variable s : std_logic_vector (1 downto 0) := "00";

  begin  -- process file_loop
    if not endfile(inf) then
      wait for clk_period/2;
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      case state is
        when "00" =>
          state <= "01";
        when "01" =>
          state <= "11";
        when "11" =>
          state <= "10";
        when "10" =>
          state <= "00";
        when others =>
          state <= "00";
      end case;
      readline(inf, l);
      read(l, aa);
      read(l, ss);           -- read in the space character
      read(l , bb);
      read(l, ss);           -- read in the space character
      read(l , cc);
      a <= aa;
      b <= bb;
      cccc <= cc;
      if cccc = c or s /= "11" then
        Q <= '0';
      else
        Q <= '1';
        assert false report "lt test not passed!!" severity failure;
      end if;
      if s (0) = '0' then        
        s (0) := '1';
      else
        s (1) := '1';
      end if;
    else
      wait;
    end if;
  end process main_loop;

end architecture lt_sim;

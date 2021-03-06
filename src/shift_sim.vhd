library  ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity shift_sim is  
  port (
    Q : out std_logic);
end entity shift_sim;

architecture shift_sim of shift_sim is

  component alu is
    port (
      clk        : in  std_logic;
      opc_alu    : in  std_logic_vector(6 downto 0);
      reg_in_a   : in  std_logic_vector(31 downto 0);
      reg_in_b   : in  std_logic_vector(31 downto 0);
      reg_out    : out std_logic_vector(31 downto 0);
      shift_dir  : in  std_logic;
      shift_type : in  std_logic_vector(1 downto 0);
      shift_go   : in  std_logic);
  end component alu;

  signal a : std_logic_vector (31 downto 0) := (others => '0');
  signal b : std_logic_vector (31 downto 0) := (others => '0');
  signal c : std_logic_vector (31 downto 0) := (others => '0');  
  signal clk : std_logic := '0';

  type buff is array (3 downto 0) of std_logic_vector (31 downto 0);
  signal cc : buff := (others => (others => '0'));
  signal cccc : std_logic_vector (31 downto 0) := (others => '0');  
  signal tmpc : std_logic_vector (31 downto 0) := (others => '0');  
  signal state : std_logic_vector (2 downto 0) := (others => '0');
  signal s : std_logic := '0';
  constant clk_period : time := 10 ns;
  constant opcode : std_logic_vector (6 downto 0) := "0010000";
  signal shift_dir : std_logic := '0';
  signal shift_type : std_logic_vector (1 downto 0) := (others => '0');
  signal shift_go : std_logic := '0';
  file inf : text;
begin  -- architecture shift_sim

  file_open(inf, "shift.dat",  read_mode);
  i_alu : alu port map (clk,opcode,a,b,c,shift_dir,shift_type,shift_go);

  with state select
    shift_go <=
    '1' when "000",
    '0' when others;

  main_loop: process 
    variable l : line;
    variable aa : std_logic_vector (31 downto 0) := (others => '0');
    variable bb : std_logic_vector (31 downto 0) := (others => '0');
    variable cc : std_logic_vector (31 downto 0) := (others => '0');
    variable lr : std_logic := '0';
    variable kind : std_logic_vector (1 downto 0) := (others => '0');
    variable ss : character;
    variable s : std_logic_vector (1 downto 0) := "00";

  begin  -- process file_loop
    if not endfile(inf) then
      wait for clk_period/2;
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      case state is
        when "000" =>
          state <= "001";
        when "001" =>
          state <= "011";
        when "011" =>
          state <= "111";
        when "111" =>
          state <= "110";
        when "110" =>
          state <= "100";
        when others =>
          state <= "000";
      end case;
      if state = "000" then
        readline(inf, l);
        hread(l, aa);
        read(l, ss);           -- read in the space character
        hread(l , bb);
        read(l, ss);           -- read in the space character
        hread(l , cc);
        read(l, ss);           -- read in the space character
        read(l , lr);
        read(l, ss);           -- read in the space character
        read(l , kind);
        a <= aa;
        b <= bb;
        tmpc <= cc;
        shift_dir <= lr;
        shift_type <= kind;
      elsif state = "100" then
        if tmpc = c or s /= "11" then
          Q <= '0';
        else
          Q <= '1';
          assert false report "shift test not passed!!" severity failure;
        end if;
        if s (0) = '0' then        
          s (0) := '1';
        else
          s (1) := '1';
        end if;
      end if;
    else
      wait;
    end if;
  end process main_loop;

end architecture shift_sim;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Byte_RAM is
  port (
    WE    : in  std_logic;                      -- 書き込み許可信号
    C     : in  std_logic;                      -- クロック信号
    mode  : in  std_logic_vector(1 downto 0);   -- 書き込み、読み込み時の容量選択
                                                  -- 0 : バイト単位
                                                  -- 1 : ハーフワード単位
                                                  -- 2 : ワード単位
    A     : in  std_logic_vector(18 downto 0);  -- バイト単位のアドレス指定
    Din   : in  std_logic_vector(31 downto 0);  -- 32ビットデータ入力
    D  : out std_logic_vector(31 downto 0);  -- 32ビットデータ出力

    A2   : in  std_logic_vector(18 downto 0);  -- デュアルポート対応 (アドレス指定)
    D2   : out std_logic_vector(31 downto 0)  -- デュアルポート対応 (データ出力)
  );
end Byte_RAM;

architecture RTL of Byte_RAM is

  type ByteArray is array (0 to (2**19 + 2)) of std_logic_vector(7 downto 0);
  signal Memory : ByteArray := (others => (others => '0'));
  
begin

  D(7 downto 0) <= Memory(to_integer(unsigned(A)));
  D(15 downto 8) <= Memory(to_integer(unsigned(A)) + 1);
  D(23 downto 16) <= Memory(to_integer(unsigned(A)) + 2);
  D(31 downto 24) <= Memory(to_integer(unsigned(A)) + 3);

  process (C)
  begin
    if rising_edge(C) then
      if WE = '1' then
        case mode is
          when "00" =>
            Memory(to_integer(unsigned(A)))     <= Din(7 downto 0);
          when "01" =>
            Memory(to_integer(unsigned(A)))     <= Din(7 downto 0);
            Memory(to_integer(unsigned(A)) + 1) <= Din(15 downto 8);
          when "10" =>
            Memory(to_integer(unsigned(A)))     <= Din(7 downto 0);
            Memory(to_integer(unsigned(A)) + 1) <= Din(15 downto 8);
            Memory(to_integer(unsigned(A)) + 2) <= Din(23 downto 16);
            Memory(to_integer(unsigned(A)) + 3) <= Din(31 downto 24);
          when others => null;
        end case;
      end if;
    end if;
  end process;

  process (A2)
  begin
    -- デュアルポート対応
    D2(7 downto 0) <= Memory(to_integer(unsigned(A2)));
    D2(15 downto 8) <= Memory(to_integer(unsigned(A2)) + 1);
    D2(23 downto 16) <= Memory(to_integer(unsigned(A2)) + 2);
    D2(31 downto 24) <= Memory(to_integer(unsigned(A2)) + 3);
  end process;

end RTL;
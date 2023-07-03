----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/02/2023 01:49:14 PM
-- Design Name: 
-- Module Name: encryptor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned;
use IEEE.std_logic_unsigned;
use ieee.numeric_std.all;
use ieee.std_logic_textio;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encryptor is
    Port(
        clk, reset,start: in STD_LOGIC
    );
--  Port ( );

end encryptor;

architecture Behavioral of encryptor is

        signal v0: std_logic_vector(31 downto 0)        :="11100000000001100000000000000011";
        signal v1: std_logic_vector(31 downto 0)        :="11100000000001100000000000000011";
        signal delta: std_logic_vector(31 downto 0)     :="11100000000001100000000000000011";
        signal temp_m1: std_logic_vector(31 downto 0)   :="00000000000000000000000000000000";
        signal temp_m2: std_logic_vector(31 downto 0)   :="00000000000000000000000000000000";
        signal temp_m3: std_logic_vector(31 downto 0)   :="00000000000000000000000000000000";
        signal temp_m4: std_logic_vector(31 downto 0)   :="00000000000000000000000000000000";
        signal temp_m5: std_logic_vector(31 downto 0)   :="00000000000000000000000000000000";
        signal temp_m6: std_logic_vector(31 downto 0)   :="00000000000000000000000000000000";
        signal res: std_logic_vector(31 downto 0)       :="00000000000000000000000000000000";
        signal sum: std_logic_vector(31 downto 0)       :="10100000000000000000000000000101";
        signal keyOne: std_logic_vector(31 downto 0)    :="00000000000000000000000000000000";
        signal testOne: std_logic_vector(7 downto 0)    :="00000001";
        signal testTwo: std_logic_vector(7 downto 0)    :="00000011";
        signal testSum: std_logic_vector(7 downto 0)    :="00000011";
        
           
        type t_states is (idle,clockOne,clockTwo,clockThree);
        signal s_states : t_states;
        
    begin
    -----------------------
    
    
    process(clk,reset)
    begin
        if reset = '1' then 
            s_states <= idle;
        elsif rising_edge (clk) then
            s_states <= idle;
        case s_states is
            when idle => 
                if start = '0' then 
                    s_states <= idle;
                else
                    s_states <= clockOne;
            end if;  
            -- encryptor cycle
            when clockOne => 
                -- clock one
                temp_m1 <= v1( v1'high-4 downto 0) & "0000"  ;
                temp_m2 <=  "00000"  & v1( v1'high downto 5) ;
                temp_m3 <= temp_m1  xor temp_m2;
                -- TODO add two signals
                --      --res <= temp_m3 + v1;
                temp_m4 <= std_logic_vector(unsigned(temp_m3) + unsigned(v1));
                --testSum <= std_logic_vector(unsigned(testOne) + unsigned(testTwo));
                --right side miro
                temp_m5 <= sum AND "00000000000000000000000000000011";
                --TODO index keyOne[temp_m4]
                -- temp_m6 <= std_logic_vector(unsigned(keyOne[temp_m4]) + unsigned(sum));
                
                --
                -- Data: in std_logic_vector(7 downto 0);
                -- signal counter : std_logic_vector(3 downto 0);
                -- output <= Data(to_integer(unsigned(counter))); 
                s_states <= clockTwo;
            when clockTwo =>
            
                -- clock two
                -- left side
                temp_m1 <= temp_m4 xor v1;
                v0 <= std_logic_vector(unsigned(temp_m1) + unsigned(v0));
                temp_m2 <= v0(v0'high-4 downto 0) & "0000";
                temp_m3 <= "00000"& v0(v0'high downto 5);
                temp_m4 <= temp_m2 xor temp_m3;
            
                -- right side
                sum <= std_logic_vector(unsigned(sum) + unsigned(delta));
                temp_m5 <= sum(sum'high downto 11) & "00000000000";
                temp_m6 <= temp_m5 AND "00000000000000000000000000000011";
                --TODO index keyOne[temp_m4]
                -- temp_m3 <= std_logic_vector(unsigned(keyOne[temp_m4]) + unsigned(sum));
                        
                s_states <= clockThree;        
            when clockThree =>
                    
                --clock three
                temp_m1 <= std_logic_vector(unsigned(temp_m6) + unsigned(v0));
                -- temp_m2 <= std_logic_vector(unsigned(temp_m4) + unsigned(sum));
                temp_m3 <= temp_m1 xor temp_m2 ; 
                v1 <= std_logic_vector(unsigned(temp_m6) + unsigned(v1));
                s_states <= idle; 
        end case;       
        --elsif idle'event and idle='1' then
     end if;
     --   if rising_edge (clk) then
    end process;
  --Test commands 
   --report "mySignal = " & to_string(myVar);
  --report "mySignal = " & to_string(mySignal);
   -- myVar <= myVar( myVar'high-1 downto 0) & "0" ;
    --myVar <= myVar( myVar'high-1 downto 0) & "0" ;
    --myVar2 <= "1" & myVar2( myVar2'high downto 1)  ;
    --myVar2 <= "1" & myVar2( myVar2'high downto 1)  ;
    --myXor <= myVar xor myVar2;
  
end Behavioral;


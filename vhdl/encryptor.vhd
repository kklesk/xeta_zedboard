----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/12/2023 11:58:52 PM
-- Design Name: 
-- Module Name: xtea - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- lib for bitshifting
use ieee.numeric_std.all;
--use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity xtea is
    Port ( 
    clk, reset,start: in STD_LOGIC;
        
    input_hexOne : in STD_LOGIC_VECTOR(31 downto 0);
    input_hexTwo : in STD_LOGIC_VECTOR(31 downto 0);
    input_numOfCycles : in STD_LOGIC_VECTOR(7 downto 0);
    input_keyOne: in STD_LOGIC_VECTOR(31 downto 0);
    input_keyTwo: in STD_LOGIC_VECTOR(31 downto 0);
    input_keyThree: in STD_LOGIC_VECTOR(31 downto 0);
    output_hexOne: out std_logic_vector(31 downto 0);
    output_hextwo: out std_logic_vector(31 downto 0)
    );
end xtea;

architecture Behavioral of xtea is
    --
    --signal first_string: unsigned(0 to 8);
    signal input_string_one: STD_LOGIC_VECTOR(31 downto 0);
    --signal second_string: unsigned(0 to 8);
    signal input_string_two: STD_LOGIC_VECTOR(31 downto 0);
    --TODO declare delta from wikipedia example
    signal delta: STD_LOGIC_VECTOR( 31 downto 0 ):= x"9E3779B9";
    --signal Data_Byte : std_logic_vector( 7 downto 0) := x"41";
    --signal temp: unsigned (7 downto 0);
               
    signal A_encipher_shifting: std_logic_vector(31 downto 0);
    signal B_decipher_shifting: std_logic_vector(31 downto 0);
    signal A_sum: std_logic_vector(31 downto 0);
    signal B_sum: std_logic_vector(31 downto 0);
    signal result_one: std_logic_vector(7 downto 0);
    
   
    type t_states is (idle,clockOne,clockTwo,clockThree);
    signal s_states : t_states;

    
    begin
    
        input_string_one <= (input_hexOne);
        input_string_two <= (input_hexOne);
    process(clk,reset)
    begin
        if reset = '1' then 
            s_states <= idle;
        if rising_edge (clk) then
        case s_states is
            when idle => 
                if start = '0' then 
                    s_states <= idle;
                else
                    s_states <= clockOne;
            end if;  
            -- first cycle
            when clockOne => 
                A_encipher_shifting <= std_logic_vector (unsigned (input_string_one) sll 4) ; 
                B_decipher_shifting <= std_logic_vector (unsigned (input_string_two) srl 5) ; 
                A_sum <= std_logic_vector (unsigned (input_string_one) srl 5); 
                -- TODO 
                --B_sum <= B_sum & '3';
                B_sum <= B_sum + delta;
                s_states <= clockTwo;
            
            when clockTwo => 
                s_states <= clockThree;
            
            when clockThree =>
                s_states <= idle;
            
            end case;       
        --elsif idle'event and idle='1' then
        end if;
     --   if rising_edge (clk) then
    end process;
end Behavioral;

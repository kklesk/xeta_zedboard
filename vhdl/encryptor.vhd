----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2023 12:20:54 PM
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

entity encryptor is
-- read only one char (8-bit)
    Port ( 
        -- num_cycles: 8-bit max 32 iterations
           num_cycles : in STD_LOGIC_VECTOR(8 downto 0);
           input_hex_one : in STD_LOGIC_VECTOR(31 downto 0);
        -- input_hex : in STD_LOGIC_VECTOR(31 downto 0);
           input_hex_two : in STD_LOGIC_VECTOR(31 downto 0);
        -- input_hex_two : in STD_LOGIC_VECTOR(31 downto 0);
           key_one : in STD_LOGIC_VECTOR(31 downto 0);
           key_two : in STD_LOGIC_VECTOR(31 downto 0);
           key_three : in STD_LOGIC_VECTOR(31 downto 0);
           key_four : in STD_LOGIC_VECTOR(31 downto 0);

           output_hex_one : out STD_LOGIC;
           output_hex_two : out STD_LOGIC);

           
end encryptor;

architecture Behavioral of encryptor is
--signal first_string: unsigned(0 to 8);
signal input_string_one: STD_LOGIC_VECTOR(31 downto 0);
--signal second_string: unsigned(0 to 8);
signal input_string_two: STD_LOGIC_VECTOR(31 downto 0);
--TODO declare delta from wikipedia example
signal delta: STD_LOGIC_VECTOR( 31 downto 0 ):= x"9E3779B9";
--signal Data_Byte : std_logic_vector( 7 downto 0) := x"41";
signal temp: unsigned (7 downto 0);
           
signal A_encipher_shifting: std_logic_vector(31 downto 0);
signal B_decipher_shifting: std_logic_vector(31 downto 0);
signal A_sum: std_logic_vector(31 downto 0);
signal B_sum: std_logic_vector(31 downto 0);
signal result_one: std_logic_vector(7 downto 0);
 
begin
-- TODO is this nessecary? 
-- Solution ==> a_one <= std_logic_vector (unsigned (input_hex_one) sll 4) ; 
-- TODO clocked_process https://vhdlwhiz.com/clocked-process/
    input_string_one <= (input_hex_one);
    input_string_two <= (input_hex_two);
    --delta <= x9E3779B9;
 process is
    begin
        for i in 1 to 16 loop
            report "i=" & integer'image(i);
            -- a_one <= input_hex_one sll 4 ; 
            -- cycle one
            A_encipher_shifting <= std_logic_vector (unsigned (input_hex_one) sll 4) ; 
            B_decipher_shifting <= std_logic_vector (unsigned (input_hex_one) srl 5) ; 
            A_sum <= std_logic_vector (unsigned (input_hex_one) srl 5); 
            -- TODO 
            --B_sum <= B_sum & '3';
            B_sum <= B_sum + delta;
            -- cycle two
            -- temp <= std_logic_vector (unsigned (A_encipher_shifting)) xor std_logic_vector (unsigned (B_decipher_shifting) );
            --temp <= A_encipher_shifting xor B_decipher_shifting;
            
            -- a_ <= input_string_one sll 4 ;
            -- 1.1 A=(((v1 << 4)
            -- 1.2 B=(v1 >> 5)
            -- 1.3 C= (A XOR B) + 1
            -- 2.1.1 index_A = sum >> 11
            -- 2.1.2 
            -- 2.1.3 sum = (sum
            --first_string <= second_string sll 4;
            --first_string <= first_string xor 
        end loop;
        wait;
         
    end process;
    

end Behavioral;

-- procedure encrypt(string_one: std_logic_vector, string_two: std_logic_vector)


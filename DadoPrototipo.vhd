Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity DadoPrototipo is
    port
    (
    clk_50, env_data, truc: in std_logic;--al cristal de 50MHZ y env data es el boton
    salidaDs: out std_logic_vector(5 downto 0));

end DadoPrototipo;

Architecture special of DadoPrototipo is
   signal conteo: std_logic_vector(2 downto 0);
   signal conteo_deco: std_logic_vector(5 downto 0);
      begin
        process(clk_50)
            begin
            if(clk_50' event and clk_50='1')then
					if (truc='1') then
						conteo<="011";
               elsif (env_data='0') then
                  conteo<=conteo+'1';
               elsif (env_data='1') then
                  conteo<=conteo;
               end if;
            end if;

       
        end process;  
        
    conteo_deco <=
        "000001" when (conteo="001")else--1
        "000010" when (conteo="010")else--2
        "000100" when (conteo="011")else--3
        "001000" when (conteo="100")else--4
        "010000" when (conteo="101")else--5
        "100000" when (conteo="110")else--6
        "000000"  ;

    salidaDs <= conteo_deco when (env_data='1') else
    "000000";    
end special;
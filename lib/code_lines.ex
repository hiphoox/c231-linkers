defmodule CodeLines do
	def lines(program,linea) when program != []  do
   		codigo_linea=hd program
   		otras_lineas=tl program
   		lista_token_sin_num = Regex.split(~r/\s+/,codigo_linea, trim: true)
   		lista_token_con_num=Enum.flat_map(lista_token_sin_num, fn x -> [{x,linea}] end)
   		linea=linea+1
   		otrostokens=lines(otras_lineas,linea)
   		lista_token_con_num ++ otrostokens
     end

     def lines(_program,_linea)  do
          []
     end
end
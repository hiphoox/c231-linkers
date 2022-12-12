defmodule Evaluator do
  def evaluator_lexer(token_list) when token_list != [] do
		[head|tail] = token_list
		{token,info} = head

		if token != :error do
			evaluator_lexer(tail)
		else
			msj_lexer(info)
			evaluator_lexer(tail)
			:error
		end
	end

	def evaluator_lexer(_)do
		:ok
	end

	def msj_lexer({string,num_line}) do

		#IO.puts("Error lexico:")
		#{string,num_line} = info
		line = to_string(num_line)
		"Token not valid: " <> string = string

		#mensaje_error
		#IO.inspect("La ("<>string<>") es no esperada en linea: "<>line)
		IO.inspect("Error lexico: ("<>string<>") se encuentra un token no reconocido, en linea: "<>line)
	end
end

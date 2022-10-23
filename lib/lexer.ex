defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

   def get_constant(program,linea) do
    valor=Regex.run(~r/^\d+/, program)
    if valor != :nil do
      case valor do
        [value] ->
        {{{:constant, String.to_integer(value)},linea}, String.trim_leading(program, value)}
      end
    else
      {["Token not valid",program,linea],:error}
    end
  end

  def lex_raw_tokens({program,linea}) when program != "" do
    code_line = linea
    {token, rest} =
      case program do
        "{" <> rest ->
          {{:open_brace, code_line}, rest}

        "}" <> rest ->
          {{:close_brace, code_line}, rest}

        "(" <> rest ->
          {{:open_paren, code_line}, rest}

        ")" <> rest ->
          {{:close_paren, code_line}, rest}

        ";" <> rest ->
          {{:semicolon, code_line}, rest}

        "return" <> rest ->
          {{:return_keyword, code_line}, rest}

        "int" <> rest ->
          {{:int_keyword, code_line}, rest}

        "main" <> rest ->
          {{:main_keyword, code_line}, rest}

        rest ->
          get_constant(rest,linea)
      end

    if rest != :error do
      auxiliar_token={rest,linea}
      remaining_tokens=lex_raw_tokens(auxiliar_token)
      [token | remaining_tokens]
    else
      remaining_tokens=lex_raw_tokens(rest)
    [token | remaining_tokens]
    #  [{:error}]
    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end

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
      {:error,{"Token not valid: #{program}",linea}}
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

        "&&" <> rest ->
          {{:and, code_line}, rest}

        "||" <> rest ->
          {{:or, code_line}, rest}

        "==" <> rest ->
          {{:equal, code_line}, rest}

        "!=" <> rest ->
          {{:not_equal, code_line}, rest}

        "<=" <> rest ->
          {{:less_than_or_equal, code_line}, rest}

        ">=" <> rest ->
          {{:greater_than_or_equal, code_line}, rest}

        ">" <> rest ->
          {{:greater_than, code_line}, rest}

        "<" <> rest ->
          {{:less_than, code_line}, rest}

        "-" <> rest ->
          {{:negation, code_line}, rest}

        "~" <> rest ->
          {{:bitwise_complement, code_line}, rest}

        "!" <> rest ->
          {{:logical_negation, code_line}, rest}

        "return" <> rest ->
          if String.first(rest) in ["{","}","(",")",";","-","~","!",nil] do
            {{:return_keyword, code_line}, rest}
          else
            {:error,{"Token not valid: #{program}",linea}}
          end

        "int" <> rest ->
          if String.first(rest) in ["{","}","(",")",";","-","~","!",nil] do
            {{:int_keyword, code_line}, rest}
          else
            {:error,{"Token not valid: #{program}",linea}}
          end

        "main" <> rest ->
        if String.first(rest) in ["{","}","(",")",";","-","~","!",nil] do
          {{:main_keyword, code_line}, rest}
        else
          {:error,{"Token not valid: #{program}",linea}}
        end

        "+" <> rest ->
          {{:addition, code_line}, rest}

        "*" <> rest ->
          {{:multiplication, code_line}, rest}

        "/" <> rest ->
          {{:division, code_line}, rest}

        rest ->
          get_constant(rest,linea)
      end

    if token != :error do
      auxiliar_token={rest,linea}
      remaining_tokens=lex_raw_tokens(auxiliar_token)
      [token | remaining_tokens]
    else
      [{:error, rest}]
    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end

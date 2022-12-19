defmodule Parser do
  def parse_program(token_list) when token_list != [] do

    function = parse_function(token_list,0)
    case function do
      {{:error,error_message,linea,problema}, _rest} ->
        {:error, error_message, linea,problema}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: Hay más elementos después del final de la función",0,"}"}
        end
    end

  end

  def parse_program(_) do
    {:error, "Archivo sin elementos",0,"--"}
  end

  def parse_function([{next_token,numline} | rest],contador) do
    if rest != [] do
      case contador do
        0->
          if next_token == :int_keyword do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: falta el tipo de valor de retorno",numline,next_token},rest}
          end
        1->
          if next_token == :main_keyword do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: falta la función principal main",numline,next_token},rest}
          end
        2->
          if next_token == :open_paren do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: falta el paréntesis abierto",numline,next_token},rest}
          end
        3->
          if next_token == :close_paren do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: falta el paréntesis de cierre",numline,next_token},rest}
          end
        4->
          if next_token == :open_brace do
            statement = parse_statement(rest)
            case statement do
              {{:error, error_message,numline,next_token}, rest} ->
                {{:error, error_message,numline,next_token}, rest}

              {statement_node,lista_rest} ->
                if lista_rest != [] do
                  [{next_token,numline}|rest] = lista_rest
                  if next_token == :close_brace do
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                  else
                    {{:error, "Error: falta la llave abierta",numline,next_token}, rest}
                  end
                else
                    {{:error, "Error: falta la llave de cierre",numline,next_token}, rest}
                end
            end
          else
            {{:error, "Error: open brace missed",numline,next_token}, rest}
          end
      end
    else
      {{:error, "Error: incomplete program",numline,next_token}, []}
    end
  end


  def parse_statement([{next_token,numline} | rest]) do
    if next_token == :return_keyword do
      expression = parse_expression(rest)

      case expression do
        {{:error, error_message, _, _}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        {exp_node, [{next_token,numline}| rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error,"Error: semicolon missed after constant to finish return statement",
                      numline,next_token}, rest}
          end
      end
    else
      {{:error, "Error: return keyword missed",numline,next_token}, rest}
    end
  end

  def parse_expression(rest) do
    if rest != [] do
      [{next_token,numline} | rest] = rest

      case next_token do
        {:constant, value} ->
          {%AST{node_name: :constant, value: value}, rest}

        _ ->
          op = unary_op(next_token)
          if op == :ok do
            exp = parse_expression(rest)
            case exp do
              {{:error, error_message, numline,next_token}, rest} ->
                {{:error, error_message, numline,next_token}, rest}

              {nodo,rest} ->
                {%AST{node_name: next_token, left_node: nodo}, rest}
            end
          else
            {{:error, "Error: constant value missed",numline,next_token}, rest}
          end
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def unary_op(next_token) do
    case next_token do
      :negation ->
        :ok

      :bitwise_complement ->
        :ok

      :logical_negation ->
        :ok

      _ -> :error
    end
  end

end

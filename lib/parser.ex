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
          {:error, "Error: there are more elements after function end",0,"more elements"}
        end
    end

  end

  def parse_program(_) do
    {:error, "File without elements",0,"more elements"}
  end

  def parse_function([{next_token,numline} | rest],contador) do
    if rest != [] do
      case contador do
        0->
          if next_token == :int_keyword do
            parse_function(rest,contador+1)
          else
            {{:error, "Error, return type value missed",numline,next_token},rest}
          end
        1->
          if next_token == :main_keyword do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: main function missed",numline,next_token},rest}
          end
        2->
          if next_token == :open_paren do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: open parentesis missed",numline,next_token},rest}
          end
        3->
          if next_token == :close_paren do
            parse_function(rest,contador+1)
          else
            {{:error, "Error: close parentesis missed",numline,next_token},rest}
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
                    {{:error, "Error: close brace missed",numline,next_token}, rest}
                  end
                else
                    {{:error, "Error: close brace missed",numline,next_token}, rest}
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
        {{:error, error_message, numline,next_token}, rest} ->
          {{:error, error_message, numline,next_token}, rest}

        {exp_node, [{next_token,numline}| rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error,"Error: semicolon missed after constant to finish return
                      statement",numline,next_token}, rest}
          end
      end
    else
      {{:error, "Error: return keyword missed",numline,next_token}, rest}
    end
  end

  def parse_expression([{next_token,numline} | rest]) do
    case next_token do
      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}
      _ -> {{:error, "Error: constant value missed",numline,next_token}, rest}
    end
  end
end

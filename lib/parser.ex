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
            {{:error, "Error: falta la llave abierta",numline,next_token}, rest}
          end
      end
    else
      {{:error, "Error: programa incompleto",numline,next_token}, []}
    end
  end


  def parse_statement([{next_token,numline} | rest]) do
    if next_token == :return_keyword do
      expression = parse_exp(rest)

      case expression do
        {{:error, error_message, 0, 0}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}


        {exp_node, [{next_token,numline}| rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error,"Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno",
                      numline,next_token}, rest}
          end
      end
    else
      {{:error, "Error: falta la palabra clave 'return'",numline,next_token}, rest}
    end
  end

  def parse_additive_exp(toks) do
    if toks != [] do
      term = parse_term(toks)
      case term do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        _ ->
          parse_additive_exp_extra(term)
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def parse_additive_exp_extra(term) do
    {leftNode, toks_rest} = term
    [{next_token,_}|rest] = toks_rest

    case next_token do
      :addition ->
        term = parse_term(rest)
        case term do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = term
            node = {%AST{node_name: :addition, left_node: leftNode, right_node: rightNode}, rest}
            parse_additive_exp_extra(node)
        end

      :negation ->
        term = parse_term(rest)
        case term do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = term
            node = {%AST{node_name: :negation, left_node: leftNode, right_node: rightNode}, rest}
            parse_additive_exp_extra(node)
        end

      _->
        term
      end
  end


  def parse_term(toks) do
    if toks != [] do
      factor = parse_factor(toks)
      case factor do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        _ ->
          parse_term_extra(factor)
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def parse_term_extra(factor) do
    {leftNode,toks_rest} = factor
    [{next_token,_}|rest] = toks_rest

    case next_token do
      :multiplication ->
        factor = parse_factor(rest)
        case factor do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode, rest} = factor
            node = {%AST{node_name: :multiplication, left_node: leftNode, right_node: rightNode}, rest}
            parse_term_extra(node)
        end

      :division ->
        factor = parse_factor(rest)
        case factor do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode, rest} = factor
            node = {%AST{node_name: :division, left_node: leftNode, right_node: rightNode }, rest}
            parse_term_extra(node)
        end

      _->
        factor
    end
  end

  def parse_factor(toks) do
    [{next_token,numline} | rest] = toks

    case next_token do
    :open_paren->
      expression = parse_exp(rest)
      case expression do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        {exp_node, toks_rest} ->
          [{next_token,numline}|rest] = toks_rest
          if next_token == :close_paren do
            {exp_node, rest}
          else
            {{:error, "Error: Se esperaba ')' ",numline,next_token}, rest}
            #Error
          end
      end

    {:constant, value} ->
      {%AST{node_name: :constant, value: value}, rest}

    _->
      op = unary_op(next_token)
      if op == :ok do
        exp = parse_factor(rest)
        case exp do
          {{:error, error_message, numline,next_token}, rest} ->
            {{:error, error_message, numline,next_token}, rest}

          {nodo,rest} ->
            {%AST{node_name: next_token, left_node: nodo}, rest}
        end
      else
        {{:error, "Error: La expresión del retorno es incorrecta",numline,next_token}, rest}
      end
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

  # Parte 4

  def parse_exp(toks) do
    if toks != [] do
      logical_and = parse_logical_and_exp(toks)
      case logical_and do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        _ ->
          parse_exp_extra(logical_and)
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def parse_exp_extra(logical_and) do
    {leftNode, toks_rest} = logical_and
    [{next_token,_}|rest] = toks_rest

    case next_token do
      :or ->
        logical_and = parse_logical_and_exp(rest)
        case logical_and do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = logical_and
            node = {%AST{node_name: :or, left_node: leftNode, right_node: rightNode}, rest}
            parse_exp_extra(node)
        end

      _->
        logical_and
    end
  end

  def parse_logical_and_exp(toks) do
    if toks != [] do
      equality = parse_equality_exp(toks)
      case equality do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        _ ->
          parse_logical_and_exp_extra(equality)
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def parse_logical_and_exp_extra(equality) do
    {leftNode, toks_rest} = equality
    [{next_token,_}|rest] = toks_rest

    case next_token do
      :and ->
        equality = parse_equality_exp(rest)
        case equality do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = equality
            node = {%AST{node_name: :and, left_node: leftNode, right_node: rightNode}, rest}
            parse_logical_and_exp_extra(node)
        end

      _->
        equality
    end
  end

  def parse_equality_exp(toks) do
    if toks != [] do
      relational = parse_relational_exp(toks)
      case relational do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        _ ->
          parse_equality_exp_extra(relational)
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def parse_equality_exp_extra(relational) do
    {leftNode, toks_rest} = relational
    [{next_token,_}|rest] = toks_rest

    case next_token do
      :not_equal ->
        relational = parse_relational_exp(rest)
        case relational do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = relational
            node = {%AST{node_name: :not_equal, left_node: leftNode, right_node: rightNode}, rest}
            parse_equality_exp_extra(node)
        end

      :equal ->
        relational = parse_relational_exp(rest)
        case relational do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = relational
            node = {%AST{node_name: :equal, left_node: leftNode, right_node: rightNode}, rest}
            parse_equality_exp_extra(node)
        end

      _->
        relational
    end
  end

  def parse_relational_exp(toks) do
    if toks != [] do
      additive = parse_additive_exp(toks)
      case additive do
        {{:error, error_message, numline, next_token}, rest} ->
          {{:error, error_message, numline, next_token}, rest}

        _ ->
          parse_relational_exp_extra(additive)
      end
    else
      {{:error, "Error: programa incompleto", 0, 0}, []}
    end
  end

  def parse_relational_exp_extra(additive) do
    {leftNode, toks_rest} = additive
    [{next_token,_}|rest] = toks_rest

    case next_token do
      :less_than ->
        additive = parse_additive_exp(rest)
        case additive do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = additive
            node = {%AST{node_name: :less_than, left_node: leftNode, right_node: rightNode}, rest}
            parse_relational_exp_extra(node)
        end

      :greater_than ->
        additive = parse_additive_exp(rest)
        case additive do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = additive
            node = {%AST{node_name: :greater_than, left_node: leftNode, right_node: rightNode}, rest}
            parse_relational_exp_extra(node)
        end

      :less_than_or_equal ->
        additive = parse_additive_exp(rest)
        case additive do
          {{:error, error_message, numline, next_token}, rest} ->
            {{:error, error_message, numline, next_token}, rest}

          _ ->
            {rightNode,rest} = additive
            node = {%AST{node_name: :less_than_or_equal, left_node: leftNode, right_node: rightNode}, rest}
            parse_relational_exp_extra(node)
        end

        :greater_than_or_equal ->
          additive = parse_additive_exp(rest)
          case additive do
            {{:error, error_message, numline, next_token}, rest} ->
              {{:error, error_message, numline, next_token}, rest}

            _ ->
              {rightNode,rest} = additive
              node = {%AST{node_name: :greater_than_or_equal, left_node: leftNode, right_node: rightNode}, rest}
              parse_relational_exp_extra(node)
          end
      _->
        additive
    end
  end

end

defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  setup_all do
    {:ok,
     arbol: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: nil,
        node_name: :constant,
        right_node: nil,
        value: 2
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol0: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: nil,
        node_name: :constant,
        right_node: nil,
        value: 2
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol1: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: nil,
        node_name: :constant,
        right_node: nil,
        value: 0
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol2: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: nil,
        node_name: :constant,
        right_node: nil,
        value: 100
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol3: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: nil,
        node_name: :constant,
        right_node: nil,
        value: 0002
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol4: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: nil,
        node_name: :constant,
        right_node: nil,
        value: 000
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
tupla_error1: {:error, "Error, return type value missed", 1, :main_keyword}

#---------------------
    }
  end

test "return 2", state do

  code = """
      int main() {
        return 2;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol0]
end

test "return 0", state do
    code = """
      int main() {
        return 0;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol1]
  end

    test "multi_digit", state do
    code = """
      int main() {
        return 100;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol2]
  end

    test "new_lines", state do
    code = """
    int
    main
    (
    )
    {
    return
    2
    ;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol]
  end

    test "no_newlines", state do
    code = """
    int main(){return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol]
  end

    test "spaces", state do
    code = """
    int   main    (  )  {   return  2 ; }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol]
  end

 test "elements separated just by spaces", state do
    assert Lexer.scan_words([{"int",0}, {"main(){return",0}, {"2;}",0}]) |> Parser.parse_program() ==
    state[:arbol]
  end

    test "function name separated of function body", state do
    assert Lexer.scan_words([{"int",0}, {"main()",0}, {"{return",0}, {"2;}",0}]) |> Parser.parse_program() == state[:arbol]
  end

    test "everything is separated", state do
    assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"2",0}, {";",0}, {"}",0}]) |> Parser.parse_program() ==
             state[:arbol]
  end

  test "separados", state do
    assert Lexer.scan_words([{"int",0}, {"main",0}, {"(){",0}, {"return",0}, {"2",0}, {";}",0}]) |> Parser.parse_program() ==
             state[:arbol]
  end

    test "ceros izquierda", state do
    code = """
      int main() {
        return 0002;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol3]
  end

    test "Multiple ceros", state do
    code = """
      int main() {
        return 000;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol4]
  end



#-----------------------------------


test "sin int", state do
  code = """
    main main() {
      return 2;
  }
  """
  s_code = Sanitizer.sanitize_source(code)
  assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error1]

end

test "lista de tokens vacia", state do
  code = """
  """
  s_code = Sanitizer.sanitize_source(code)
  assert Lexer.scan_words(s_code) |> Parser.parse_program() ==
    {:error, "File without elements",0,"more elements"}
end

 end

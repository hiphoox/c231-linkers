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
    arbol5: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 3
            },
            node_name: :logical_negation,
            right_node: nil,
            value: nil
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
    arbol6: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: %AST{
                      left_node: %AST{
                        left_node: %AST{
                          left_node: %AST{
                            left_node: %AST{
                              left_node: %AST{
                                left_node: %AST{
                                  left_node: nil,
                                  node_name: :constant,
                                  right_node: nil,
                                  value: 6
                            },
                            node_name: :logical_negation,
                            right_node: nil,
                            value: nil
                          },
                          node_name: :negation,
                          right_node: nil,
                          value: nil
                        },
                        node_name: :bitwise_complement,
                        right_node: nil,
                        value: nil
                      },
                      node_name: :bitwise_complement,
                      right_node: nil,
                      value: nil
                    },
                    node_name: :negation,
                    right_node: nil,
                    value: nil
                  },
                  node_name: :logical_negation,
                  right_node: nil,
                  value: nil
                },
                node_name: :logical_negation,
                right_node: nil,
                value: nil
              },
              node_name: :logical_negation,
              right_node: nil,
              value: nil
            },
            node_name: :logical_negation,
            right_node: nil,
            value: nil
          },
          node_name: :logical_negation,
          right_node: nil,
          value: nil
        },
        node_name: :logical_negation,
        right_node: nil,
        value: nil
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

    tupla_error1: {:error, "Error: falta el tipo de valor de retorno", 1,:main_keyword},
    tupla_error2: {:error, "Archivo sin elementos",0,"--"},
    tupla_error3: {:error, "Error: falta el punto y coma despu??s de la constante para finalizar la declaraci??n de devoluci??n",
                            2,:close_brace},
    tupla_error4: {:error, "Error: falta la funci??n principal main",1,:return_keyword},
    tupla_error5: {:error, "Error: falta el par??ntesis abierto",1,:close_paren},
    tupla_error6: {:error, "Error: falta el par??ntesis de cierre", 2, {:constant, 2}},
    tupla_error7: {:error, "Error: Hay m??s elementos despu??s del final de la funci??n",0,"}"},
    tupla_error8: {:error, "Error: programa incompleto", 1, :open_brace},
    tupla_error9: {:error, "Error: falta la llave abierta", 2, :return_keyword},
    tupla_error10: {:error, "Error: falta la llave de cierre",1,:open_brace},
    tupla_error11: {:error, "Error: falta la palabra clave 'return'", 2, {:constant, 2}},
    tupla_error12: {:error, "Error: falta el valor de la constante", 2, :semicolon},
    tupla_error13: {:error, "Error: falta el punto y coma despu??s de la constante para finalizar la declaraci??n de devoluci??n", 2, :logical_negation},
    tupla_error14: {:error, "Error: falta el punto y coma despu??s de la constante para finalizar la declaraci??n de devoluci??n", 2, :logical_negation},
    tupla_error15: {:error, "Error: falta el valor de la constante", 2, :semicolon},
    tupla_error16: {:error, "Error: falta la llave abierta", 1, :negation}
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
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error2]
  end

  test "sin punto y coma", state do
    code = """
    int main() {
      return 2}
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error3]
  end

  test "tokens en desorden", state do
     code = """
     int return main () {
      return 2; ()
      5 98 int main {}
      return ( 2 )
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error4]
   end

     test "sin ( ", state do
    code = """
      int main) {
      return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error5]
  end

  test "Ausencia de tokens", state do
    code = """
      int main(
         2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error6]
  end

    test "Token fuera de rango", state do
    code = """
      int main(){
      return  2;
    } main
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error7]
  end

  test "incompleto", state do
    code = """
      int main(){
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error8]
  end

  test "sin {", state do
    code = """
    int main()
    return  2;
  }
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error9]
  end

  test "sin }", state do
    code = """
    int main(){
    return  2;
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error10]
  end

  test "sin return", state do
    code = """
    int main(){
    2;}
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error11]
  end

  test "sin constante", state do
    code = """
    int main(){
    return  ;}
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error12]
  end

#------ Pruebas parte 2 -------

test "return !3", state do

  code = """
      int main() {
        return !3;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol5]
end

test "con varios operadores unarios", state do

  code = """
      int main() {
        return !!!!!!-~~-!6;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol6]
end

test "con operador unario a la derecha del operando", state do

  code = """
      int main() {
        return 2!;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error13]
end

test "constante en medio de operadores unarios", state do

  code = """
      int main() {
        return --8!~;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error14]
end

test "operador unario sin constante", state do

  code = """
      int main() {
        return !;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error15]
end

test "con operadores en desorden", state do

  code = """
      int main() -~ {
        return -2;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error16]
end



 end

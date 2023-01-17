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
    tupla_error3: {:error, "Error: falta el punto y coma después de la constante para finalizar la declaración de devolución",
                            2,:close_brace},
    tupla_error4: {:error, "Error: falta la función principal main",1,:return_keyword},
    tupla_error5: {:error, "Error: falta el paréntesis abierto",1,:close_paren},
    tupla_error6: {:error, "Error: falta el paréntesis de cierre", 2, {:constant, 2}},
    tupla_error7: {:error, "Error: Hay más elementos después del final de la función",0,"}"},
    tupla_error8: {:error, "Error: programa incompleto", 1, :open_brace},
    tupla_error9: {:error, "Error: falta la llave abierta", 2, :return_keyword},
    tupla_error10: {:error, "Error: falta la llave de cierre",1,:open_brace},
    tupla_error11: {:error, "Error: falta la palabra clave 'return'", 2, {:constant, 2}},
    tupla_error12: {:error, "Error: falta el valor de la constante", 2, :semicolon},
    tupla_error13: {:error, "Error: falta el punto y coma después de la constante para finalizar la declaración de devolución", 2, :logical_negation},
    tupla_error14: {:error, "Error: falta el punto y coma después de la constante para finalizar la declaración de devolución", 2, :logical_negation},
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


#--------Pruebas parte 3-----------

  test "falta constante en suma", state do

    code = """
    int main() {
    return 2+;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error17]
  end

  test "falta constante en multiplicacion", state do
    code = """
    int main() {
    return 2*;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error18]
  end

  test "falta constante en division", state do
    code = """
    int main() {
    return 2/;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error19]
  end

  test "return 2-2", state do
    code = """
    int main() {
    return 2-2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol7]
  end

  test "return 2+2", state do
    code = """
    int main() {
    return 2+2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol8]
  end

  test "return 2*2", state do
    code = """
    int main() {
    return 2*2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol9]
  end

  test "return 2/2", state do
    code = """
    int main() {
    return 2/2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol10]
  end

  test "return 2-3+4", state do
    code = """
    int main() {
    return 2-3+4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol11]
  end

  test "return 2+3*4", state do
    code = """
    int main() {
    return 2+3*4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol12]
  end

  test "return 2/3+4", state do
    code = """
    int main() {
    return 2/3+4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol13]
  end

  test "return 2*3/4", state do
    code = """
    int main() {
    return 2*3/4;
    }
    """
s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol14]
  end

  test "return 2*3-4", state do
    code = """
    int main() {
    return 2*3-4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol15]
  end

  test "return 2/3-4", state do
    code = """
    int main() {
    return 2/3-4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol16]
  end

  test "return 2/3-4*5", state do
    code = """
    int main() {
    return 2/3-4*5;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol17]
  end

  test "return 2/3-4*5+6", state do
    code = """
    int main() {
    return 2/3-4*5+6;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol18]
  end

  test "return 2-3-4", state do
    code = """
    int main() {
    return 2-3-4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol19]
  end

  test "return 2+3+4", state do
    code = """
    int main() {
    return 2+3+4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol20]
  end

  test "return 2*3*4", state do
    code = """
    int main() {
    return 2*3*4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol21]
  end

  test "return 2/3/4", state do
    code = """
    int main() {
    return 2/3/4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol22]
  end

  test "return 2++9-2/4", state do
    code = """
    int main() {
      return 2++9-2/4;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error20]
  end

  test "return 7//9+4", state do
    code = """
    int main() {
      return 7//9+4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error21]
  end

  test "return 2//3", state do
    code = """
    int main() {
      return 2//3;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error22]
  end

  test "return 8**9", state do
    code = """
    int main() {
      return 8**9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error23]
  end

  test "return -2+9/7", state do
    code = """
    int main() {
      return -2+9/7;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol23]
  end

  test "return ~-6+8*4", state do
    code = """
    int main() {
      return ~-6+8*4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol24]
  end

  test "return 5-+/9*3", state do
    code = """
    int main() {
      return 5-+/9*3;
    }
    """
s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error24]
  end

  test "return /7/", state do
    code = """
    int main() {
      return /7/;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error25]
  end
  test "return *9--", state do
    code = """
    int main() {
      return *9--;
    }
    """
s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error26]
  end
  test "return 2/-*+", state do
    code = """
    int main() {
      return 2/-*+;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error27]
  end
  test "return 3/0", state do
    code = """
    int main() {
      return 3/0;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error28]
  end

  test "return 0/5", state do
    code = """
    int main() {
      return 0/5;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol25]
  end

  test "return ~+/--", state do
    code = """
    int main() {
      return ~+/--;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error29]
  end

#------Pruebas parte 4---------

  test "return and comparation &&", state do
    code = """
    int main() {
    return 2&&2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol26]
  end
  test "return or comparation ||", state do
    code = """
    int main() {
    return 2||2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol27]
  end
  test "return equal comparation ==", state do
    code = """
    int main() {
    return 2==2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol28]
  end
  test "return not equal comparation !=", state do
    code = """
    int main() {
    return 2!=2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol29]
  end
  test "return less equal comparation <=", state do
    code = """
    int main() {
    return 2<=2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol30]
  end
  test "return less comparation <", state do
    code = """
    int main() {
    return 2<2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol31]
  end
  test "return great equal comparation >=", state do
    code = """
    int main() {
    return 2>=2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol32]
  end
  test "return great comparation >", state do
    code = """
    int main() {
    return 2>2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol33]
  end
  test "return <7", state do
    code = """
    int main() {
    return <7;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error30]
  end

  test "return &&", state do
    code = """
    int main() {
    return &&;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error31]
  end
  test "return 8=>7", state do
    code = """
    int main() {
    return 8=>7;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error32]
  end

  test "return 4=<5", state do
    code = """
    int main() {
    return 4=<5;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error33]
  end

  test "return 7===3", state do
    code = """
    int main() {
    return 7===3;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error34]
  end

  test "return 6=!9", state do
    code = """
    int main() {
    return 6=!9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error35]
  end

  test "return 7&2", state do
    code = """
    int main() {
    return 7&2;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error36]
  end

  test "return 8|7", state do
    code = """
    int main() {
    return 8|7;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error37]
  end

  test "return 1<<<9", state do
    code = """
    int main() {
    return 1<<<9;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error38]
  end

  test "return 7||6==4&&1<2", state do
    code = """
    int main() {
    return 7||6==4&&1<2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol34]
  end

  test "return 5=4", state do
    code = """
    int main() {
    return 5=4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error39]
  end

  test "return -3<9", state do
    code = """
    int main() {
    return -3<9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol35]
  end

  test "return ~7||-6", state do
    code = """
    int main() {
    return ~7||-6;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol36]
  end

  test "return --1>5", state do
    code = """
    int main() {
    return --1>5;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol37]
  end

  test "return !4<=7", state do
    code = """
    int main() {
    return !4<=7;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol38]
  end

  test "return 3+2==5*7", state do
    code = """
    int main() {
    return 3+2==5*7;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol39]
  end

  test "return 3==/9", state do
    code = """
    int main() {
    return 3==/9;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error40]
  end

  test "return 2+2||1*3", state do
    code = """
    int main() {
    return 2+2||1*3;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol40]
  end

  test "return 5-2&&4/5", state do
    code = """
    int main() {
    return 5-2&&4/5;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol41]
  end

  test "return 1+1<2+3", state do
    code = """
    int main() {
    return 1+1<2+3;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol42]
  end

  test "return 7+5<=4*2*1", state do
    code = """
    int main() {
    return 7+5<=4*2*1;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol43]
  end

  test "return 8->5", state do
    code = """
    int main() {
    return 8->5;
    }
    """
   s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error41]
  end

 end

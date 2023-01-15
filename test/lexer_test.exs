defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  setup_all do
    {:ok,
     tokens0: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {{:constant, 2}, 2},
       {:semicolon, 2},
       {:close_brace, 3}
     ],
     tokens1: [ #Diferenes líneas
      {:int_keyword, 1},
      {:main_keyword, 2},
      {:open_paren, 3},
      {:close_paren, 4},
      {:open_brace, 5},
      {:return_keyword, 6},
      {{:constant, 2}, 7},
      {:semicolon, 8},
      {:close_brace, 9}
    ],
    tokens2: [ #Una línea
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 1},
      {{:constant, 2}, 1},
      {:semicolon, 1},
      {:close_brace, 1}
    ],
    tokens3: [  #2 lineas
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:semicolon, 2},
      {:close_brace, 2}
    ],
    tokens4: [  #Error union
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:error, {"Token not valid: return2;", 2}},
      {:close_brace, 3}
    ],
    tokens5: [ #Multi error
      {:error, {"Token not valid: in", 1}},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:error, {"Token not valid: return2;", 2}},
      {:error, {"Token not valid: integer", 3}},
      {:semicolon, 3},
      {:error, {"Token not valid: g", 3}},
      {:close_brace, 4}
    ],
    tokens6: [ #Varios tokens en desorden
      {:int_keyword, 1},
      {:return_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:semicolon, 2},
      {:open_paren, 2},
      {:close_paren, 2},
      {{:constant, 5}, 3},
      {{:constant, 98}, 3},
      {:int_keyword, 3},
      {:main_keyword, 3},
      {:open_brace, 3},
      {:close_brace, 3},
      {:return_keyword, 4},
      {:open_paren, 4},
      {{:constant, 2}, 4},
      {:close_paren, 4},
      {:close_brace, 5}
    ],
    tokens7: [ #Varios token 2
      {:error, {"Token not valid: in", 1}},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:error, {"Token not valid: return2;", 2}},
      {:error, {"Token not valid: integer", 3}},
      {:semicolon, 3},
      {:error, {"Token not valid: g", 3}},
      {:close_brace, 4}
    ],
    tokens8: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {:logical_negation, 2},
       {{:constant, 3}, 2},
       {:semicolon, 2},
       {:close_brace, 3}
     ],
     tokens9: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {:negation, 2},
       {{:constant, 4}, 2},
       {:semicolon, 2},
       {:close_brace, 3}
     ],
     tokens10: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {:bitwise_complement, 2},
       {{:constant, 7}, 2},
       {:semicolon, 2},
       {:close_brace, 3}
     ],
     tokens11: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {:logical_negation, 2},
       {:bitwise_complement, 2},
       {:negation, 2},
       {{:constant, 5}, 2},
       {:semicolon, 2},
       {:close_brace, 3}
     ],
     tokens12: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {:logical_negation, 2},
       {:logical_negation, 2},
       {:logical_negation, 2},
       {:logical_negation, 2},
       {:logical_negation, 2},
       {:logical_negation, 2},
       {:negation, 2},
       {:bitwise_complement, 2},
       {:bitwise_complement, 2},
       {:negation, 2},
       {:logical_negation, 2},
       {{:constant, 6}, 2},
       {:semicolon, 2},
       {:close_brace, 3}
     ],
     tokens13: [  #Comun
       {:int_keyword, 1},
       {:main_keyword, 1},
       {:open_paren, 1},
       {:close_paren, 1},
       {:open_brace, 1},
       {:return_keyword, 2},
       {:error, {"Token not valid: +9;", 2}},
       {:close_brace, 3}
     ],
     tokens14:  [ #Return con una sola constante
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:error, {"Token not valid: +;", 2}},
      {:close_brace, 3}
    ],
    tokens15:  [
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:error, {"Token not valid: *;", 2}},
      {:close_brace, 3}
    ],
    tokens16: [
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:error, {"Token not valid: /;", 2}},
      {:close_brace, 3}
    ],
    tokens17: [ #Resta
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:negation, 2},
      {{:constant, 2}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    tokens18: [ #Suma
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:addition, 2},
      {{:constant, 2}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token19:[ #Multiplicacion
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:multiplication, 2},
      {{:constant, 2}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token20:[ #Division
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:division, 2},
      {{:constant, 2}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token21:[ #Combinado Resta y Suma
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:negation, 2},
      {{:constant, 3}, 2},
      {:addition, 2},
      {{:constant, 4}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token22:[ #Combinado Suma y mutiplicacion
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:addition, 2},
      {{:constant, 3}, 2},
      {:multiplication, 2},
      {{:constant, 4}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token23:[ #Combinado Suma y division
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:division, 2},
      {{:constant, 3}, 2},
      {:addition, 2},
      {{:constant, 4}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token24:[ #Combinado multiplicacion y division
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:multiplication, 2},
      {{:constant, 3}, 2},
      {:division, 2},
      {{:constant, 4}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token25:[ #Combinado multiplicacion y resta
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:multiplication, 2},
      {{:constant, 3}, 2},
      {:negation, 2},
      {{:constant, 4}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token26:[ #Combinado division y resta
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:division, 2},
      {{:constant, 3}, 2},
      {:negation, 2},
      {{:constant, 4}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token27:[ #Multioperacion con 3
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:division, 2},
      {{:constant, 3}, 2},
      {:negation, 2},
      {{:constant, 4}, 2},
      {:multiplication, 2},
      {{:constant, 5}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token28:[ #Multioperacion con 4
      {:int_keyword, 1},
      {:main_keyword, 1},
      {:open_paren, 1},
      {:close_paren, 1},
      {:open_brace, 1},
      {:return_keyword, 2},
      {{:constant, 2}, 2},
      {:division, 2},
      {{:constant, 3}, 2},
      {:negation, 2},
      {{:constant, 4}, 2},
      {:multiplication, 2},
      {{:constant, 5}, 2},
      {:addition, 2},
      {{:constant, 6}, 2},
      {:semicolon, 2},
      {:close_brace, 3}
    ],
    token29:[ #Multi Resta
    {:int_keyword, 1},
    {:main_keyword, 1},
    {:open_paren, 1},
    {:close_paren, 1},
    {:open_brace, 1},
    {:return_keyword, 2},
    {{:constant, 2}, 2},
    {:negation, 2},
    {{:constant, 3}, 2},
    {:negation, 2},
    {{:constant, 4}, 2},
    {:semicolon, 2},
    {:close_brace, 3}
  ],
  token30:[ #Multi Suma
    {:int_keyword, 1},
    {:main_keyword, 1},
    {:open_paren, 1},
    {:close_paren, 1},
    {:open_brace, 1},
    {:return_keyword, 2},
    {{:constant, 2}, 2},
    {:addition, 2},
    {{:constant, 3}, 2},
    {:addition, 2},
    {{:constant, 4}, 2},
    {:semicolon, 2},
    {:close_brace, 3}
  ],
  token31:[ #Multi Multiplicacion
    {:int_keyword, 1},
    {:main_keyword, 1},
    {:open_paren, 1},
    {:close_paren, 1},
    {:open_brace, 1},
    {:return_keyword, 2},
    {{:constant, 2}, 2},
    {:multiplication, 2},
    {{:constant, 3}, 2},
    {:multiplication, 2},
    {{:constant, 4}, 2},
    {:semicolon, 2},
    {:close_brace, 3}
  ],
  token32:[ #Multi Division
    {:int_keyword, 1},
    {:main_keyword, 1},
    {:open_paren, 1},
    {:close_paren, 1},
    {:open_brace, 1},
    {:return_keyword, 2},
    {{:constant, 2}, 2},
    {:division, 2},
    {{:constant, 3}, 2},
    {:division, 2},
    {{:constant, 4}, 2},
    {:semicolon, 2},
    {:close_brace, 3}
  ],
  token33:[ #And Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:and,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token34:[ #Or Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:or,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token35:[ #Equal Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:equal,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token36:[ #not equal Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:notequal,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token37:[ #less equal Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:lessequal,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token38:[ #less Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:less,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token39:[ #great equal Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:greatequal,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ],
  token40:[ #great Comparation
    {:int_keyword,1},
    {:main_keyword,1},
    {:open_paren,1},
    {:close_paren,1},
    {:open_brace,1},
    {:return_keyword,2},
    {{:constant, 2},2},
    {:great,2},
    {{:constant, 2},2},
    {:semicolon,2},
    {:close_brace,3}
  ]
    }
  end


  # tests to pass
  test "return 2", state do
    code = """
      int main() {
        return 2;
    }
    """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens0]
  end

  test "return 0", state do
    code = """
      int main() {
        return 0;
    }
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens0], 6, fn _ -> {{:constant, 0},2} end)

    assert Lexer.scan_words(s_code) == expected_result
  end

  test "multi_digit", state do
    code = """
      int main() {
        return 100;
    }
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens0], 6, fn _ -> {{:constant, 100},2} end)
    assert Lexer.scan_words(s_code) == expected_result
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

    assert Lexer.scan_words(s_code) == state[:tokens1]
  end

  test "no_newlines", state do
    code = """
    int main(){return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens2]
  end

  test "spaces", state do
    code = """
    int   main    (  )  {   return  2 ; }
    """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens2]
  end

  test "elements separated just by spaces", state do
    assert Lexer.scan_words([{"int",1}, {"main(){return",1}, {"2;}",1}]) ==
      state[:tokens2]
  end

  test "function name separated of function body", state do
    assert Lexer.scan_words([{"int",1}, {"main()",1}, {"{return",1}, {"2;}",1}]) ==
      state[:tokens2]
  end

  test "everything is separated", state do
    assert Lexer.scan_words([{"int",1}, {"main",1}, {"(",1}, {")",1}, {"{",1},
     {"return",1}, {"2",1}, {";",1}, {"}",1}]) == state[:tokens2]
  end

  # ------- Agregados Parte 1 -------
  test "separados", state do
    assert Lexer.scan_words([{"int",1}, {"main",1}, {"(){",1}, {"return",1},
      {"2",1}, {";}",1}]) == state[:tokens2]
  end

  test "ceros izquierda", state do
    code = """
      int main() {
        return 0002;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens0]
  end

  test "Multiple ceros", state do
    code = """
      int main() {
        return 000;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(
      state[:tokens0], 6, fn _ -> {{:constant, 0},2} end)

      assert Lexer.scan_words(s_code) == expected_result
  end

  test "vacio" do
    code = """
    """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == []
  end



  # tests to fail
  test "wrong case", state do
    code = """
    int main() {
      RETURN 2;
    }
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(
      state[:tokens0], 5, fn _ -> {:error, {"Token not valid: RETURN", 2}} end)

      assert Lexer.scan_words(s_code) == expected_result
  end

  #--
  test "sin punto y coma", state do
    code = """
    int main() {
      return 2}
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.delete_at(state[:tokens3], 7)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "sin int", state do
    code = """
      main() {
      return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.delete_at(state[:tokens3], 0)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "sin ( ", state do
    code = """
      int main) {
      return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.delete_at(state[:tokens3], 2)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "return", state do
    code = """
    int main() {
    retunr 2;}
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(
      state[:tokens3], 5, fn _ -> {:error, {"Token not valid: retunr", 2}} end)

      assert Lexer.scan_words(s_code) == expected_result
  end

  test "letra como constante", state do
    code = """
    int main() {
    return a ;
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(
      state[:tokens0], 6, fn _ -> {:error, {"Token not valid: a", 2}}end)

      assert Lexer.scan_words(s_code) == expected_result
  end

  test "letra como constante 2", state do
    code = """
    int main() {
    return a;
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(
      state[:tokens0], 6, fn _ -> {:error, {"Token not valid: a;", 2}} end)
    expected_result = List.delete_at(expected_result, 7)

    assert Lexer.scan_words(s_code) == expected_result
  end

  test "intmain juntos", state do
    code = """
    intmain () {
    return 2;
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(
      state[:tokens0], 0, fn _ -> {:error, {"Token not valid: intmain", 1}} end)
    expected_result = List.delete_at(expected_result, 1)


    assert Lexer.scan_words(s_code) == expected_result
  end

  test "return2; juntos", state do
    code = """
    int main () {
    return2;
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens4]
  end

  test "multiples errores", state do
    code = """
    in main () {
    return2;
    integer ; g
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens5]
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

    assert Lexer.scan_words(s_code) == state[:tokens6]
  end


  #------ Pruebas parte 2 -------

  test "return !3", state do
    code = """
      int main() {
        return !3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens8]
  end

  test "return -4", state do
    code = """
      int main() {
        return -4;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens9]
  end

  test "return ~7", state do
    code = """
      int main() {
        return ~7;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens10]
  end

  test "con los tres operadores unarios", state do
    code = """
      int main() {
        return !~-5;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens11]
  end

  test "con varios operadores unarios", state do
    code = """
      int main() {
        return !!!!!!-~~-!6;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens12]
  end

    test "operador unario y letra como constante", state do
      code = """
        int main() {
          return -a;
        }
      """

    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.update_at(
    state[:tokens9], 7, fn _ -> {:error, {"Token not valid: a;", 2}} end)
    expected_result = List.delete_at(expected_result, 8)
    assert Lexer.scan_words(s_code) == expected_result

  end

    test "operador unario no válido", state do
    code = """
    int main() {
    return +9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens13]
  end

  #Pruebas parte 3

  test "falta constante en suma", state do
    code = """
    int main() {
    return 2+;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens14]
  end

  test "falta constante en multiplicacion", state do
    code = """
    int main() {
    return 2*;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens15]
  end

  test "falta constante en division", state do
    code = """
    int main() {
    return 2/;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens16]
  end

  test "return 2-2", state do
    code = """
    int main() {
    return 2-2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens17]
  end

  test "return 2+2", state do
    code = """
    int main() {
    return 2+2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens18]
  end

  test "return 2*2", state do
    code = """
    int main() {
    return 2*2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens19]
  end

  test "return 2/2", state do
    code = """
    int main() {
    return 2/2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens20]
  end

  test "return 2-3+4", state do
    code = """
    int main() {
    return 2-3+4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens21]
  end

  test "return 2+3*4", state do
    code = """
    int main() {
    return 2+3*4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens22]
  end

  test "return 2/3+4", state do
    code = """
    int main() {
    return 2/3+4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens23]
  end

  test "return 2*3/4", state do
    code = """
    int main() {
    return 2*3/4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens24]
  end

  test "return 2*3-4", state do
    code = """
    int main() {
    return 2*3-4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens25]
  end

  test "return 2/3-4", state do
    code = """
    int main() {
    return 2/3-4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens26]
  end

  test "return 2/3-4*5", state do
    code = """
    int main() {
    return 2/3-4*5;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens27]
  end

  test "return 2/3-4*5+6", state do
    code = """
    int main() {
    return 2/3-4*5+6;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens28]
  end

  test "return 2-3-4", state do
    code = """
    int main() {
    return 2-3-4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens29]
  end

  test "return 2+3+4", state do
    code = """
    int main() {
    return 2+3+4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens30]
  end

  test "return 2*3*4", state do
    code = """
    int main() {
    return 2*3*4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens31]
  end

  test "return 2/3/4", state do
    code = """
    int main() {
    return 2/3/4;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens32]
  end

#Pruebas parte 4

  test "return and comparation &&", state do
    code = """
    int main() {
    return 2&&2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens33]
  end

  test "return or comparation ||", state do
    code = """
    int main() {
    return 2||2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens34]
  end

  test "return equal comparation ==", state do
    code = """
    int main() {
    return 2==2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens35]
  end

  test "return not equal comparation !=", state do
    code = """
    int main() {
    return 2!=2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens36]
  end

  test "return less equal comparation <=", state do
    code = """
    int main() {
    return 2<=2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens37]
  end

  test "return less comparation <", state do
    code = """
    int main() {
    return 2<2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens38]
  end

  test "return great equal comparation >=", state do
    code = """
    int main() {
    return 2>=2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens39]
  end

  test "return great comparation >", state do
    code = """
    int main() {
    return 2>2;
    }
    """
  s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens40]
  end
end

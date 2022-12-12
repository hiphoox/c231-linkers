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

  # Agregados Parte 1
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

  #------ Pruebas parte 2 -------

end

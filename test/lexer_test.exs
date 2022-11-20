defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  setup_all do
    {:ok,
     tokens: [
       {:int_keyword, 1},
       {:main_keyword, 2},
       {:open_paren, 3},
       {:close_paren, 4},
       {:open_brace, 5},
       {:return_keyword, 6},
       {{:constant, 2}, 7},
       {:semicolon, 8},
       {:close_brace, 9}
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

    assert Lexer.scan_words(s_code) == state[:tokens]
  end

  test "return 0", state do
    code = """
      int main() {
        return 0;
    }
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens], 6, fn _ -> {{:constant, 0},2} end)

    assert Lexer.scan_words(s_code) == expected_result
  end

  test "multi_digit", state do
    code = """
      int main() {
        return 100;
    }
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens], 6, fn _ -> {:constant, 100} end)
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

    assert Lexer.scan_words(s_code) == state[:tokens]
  end

  test "no_newlines", state do
    code = """
    int main(){return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens]
  end

  test "spaces", state do
    code = """
    int   main    (  )  {   return  2 ; }
    """

    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens]
  end

  test "elements separated just by spaces", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens]
  end

  test "function name separated of function body", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens]
  end

  test "everything is separated", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens]
  end

  # Agregados
  test "separados", state do
    assert Lexer.scan_words(["int", "main", "(){", "return", "2", ";}"]) ==
             state[:tokens]
  end

  test "ceros izquierda", state do
    code = """
      int main() {
        return 0002;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens]
  end

  test "Multiple ceros", state do
    code = """
      int main() {
        return 000;
    }
    """
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens], 6, fn _ -> {:constant, 0} end)
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

    expected_result = List.update_at(state[:tokens], 5, fn _ -> :error end)
    assert Lexer.scan_words(s_code) == expected_result
  end

  #--
  test "sin punto y coma", state do
    code = """
    int main() {
      return 2}
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.delete_at(state[:tokens], 7)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "sin int", state do
    code = """
      main() {
      return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.delete_at(state[:tokens], 0)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "sin ( ", state do
    code = """
      int main) {
      return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.delete_at(state[:tokens], 2)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "return", state do
    code = """
    int main() {
    retunr 2;}
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens], 5, fn _ -> :error end)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "letra como constante", state do
    code = """
    int main() {
    return a ;
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens], 6, fn _ -> :error end)
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "letra como constante 2", state do
    code = """
    int main() {
    return a;
    }
  """

    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens], 6, fn _ -> :error end)
    expected_result = List.delete_at(expected_result, 7)
    assert Lexer.scan_words(s_code) == expected_result
  end

end

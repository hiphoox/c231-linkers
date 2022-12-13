defmodule GeneratorTest do
  use ExUnit.Case
  doctest CodeGenerator

  setup_all do
    {:ok,
    codigo0: """
        .section	.text.startup,"ax",@progbits
        .p2align 4
        .globl  main
    main:
        endbr64
        movl    $2, %eax
        ret
        .section	.note.GNU-stack,"",@progbits

    """,
    codigo1: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl    $100, %eax\n    ret\n    .section	.note.GNU-stack,"",@progbits

    """,
    codigo2: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl    $0, %eax\n    ret\n    .section	.note.GNU-stack,"",@progbits

    """
    }

  end

  #----------- Parte 1 --------------
  test "Basica", state do
    assert CodeGenerator.generate_code(%AST{
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
    }) == state[:codigo0]
  end


  test "lista de tokens", state do
      assert Lexer.scan_words([{"int",1}, {"main(){return",1}, {"2;}",1}])
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() ==
      state[:codigo] or state[:codigo0]
  end

  test "Función  separada", state do
      assert Lexer.scan_words([{"int",1}, {"main()",1}, {"{return",1}, {"2;}",1}])
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() ==
      state[:codigo] or state[:codigo0]
  end

  test "Todo separado", state do
      assert Lexer.scan_words([{"int",1}, {"main",1}, {"(",1}, {")",1}, {"{",1}, {"return",1}, {"2",1}, {";",1}, {"}",1}])
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() ==
      state[:codigo] or state[:codigo0]
  end

  test "return 100", state do
    assert Lexer.scan_words([{"int",1}, {"main",1}, {"(",1}, {")",1}, {"{",1}, {"return",1}, {"100",1}, {";",1}, {"}",1}])
    |> Parser.parse_program()
    |> CodeGenerator.generate_code() == state[:codigo1]
  end

  test "return 0", state do
    assert Lexer.scan_words([{"int",1}, {"main",1}, {"(",1}, {")",1}, {"{",1}, {"return",1}, {"0",1}, {";",1}, {"}",1}])
    |> Parser.parse_program()
    |> CodeGenerator.generate_code() == state[:codigo2]
  end

  test "Saltos de linea", state do
      assert "int\nmain\n()\n{return 2;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words()
      |> Parser.parse_program()|> CodeGenerator.generate_code() ==
      state[:codigo] or state[:codigo0]
  end

  test "Separados con saltos de linea", state do
      assert "int\nmain\n(\n)\n{\nreturn\n2\n;\n}\n"
            |> Sanitizer.sanitize_source()
            |> Lexer.scan_words()
            |> Parser.parse_program()
            |> CodeGenerator.generate_code() == state[:codigo0]
  end

  test "Espacios entre tokens", state do
    assert "  int    main    (   )   {   return    2   ;   }   "
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo0]
  end
end

defmodule GeneratorTest do
  use ExUnit.Case
  doctest CodeGenerator

  setup_all do
    {:ok, #return 2
    codigo0: """
        .section	.text.startup,"ax",@progbits
        .p2align 4
        .globl  main
    main:
        endbr64
        movl  $2, %eax
        ret
        .section	.note.GNU-stack,"",@progbits

    """, #return 100
    codigo1: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $100, %eax\n    ret
        .section	.note.GNU-stack,"",@progbits

    """, #return 0
    codigo2: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $0, %eax\n    ret
        .section	.note.GNU-stack,"",@progbits

    """, #return -2
    codigo3: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n    neg	%eax\n    ret
        .section	.note.GNU-stack,"",@progbits

    """,  #return ~2
    codigo4: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n    not	%eax\n    ret
        .section	.note.GNU-stack,"",@progbits

    """, #return !2
    codigo5: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n    cmpl     $0, %eax\n    movl     $0, %eax
        sete     %al\n    ret
        .section	.note.GNU-stack,"",@progbits

    """, #return -~!2
    codigo6: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n    cmpl     $0, %eax\n    movl     $0, %eax
        sete     %al\n    not	%eax\n    neg	%eax\n    ret
        .section	.note.GNU-stack,"",@progbits

    """, #return !~-2
    codigo7: """
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n    neg	%eax\n    not	%eax
        cmpl     $0, %eax\n    movl     $0, %eax\n    sete     %al\n    ret
        .section	.note.GNU-stack,"",@progbits

    """,#---return 2+2
    codigo8:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n  mov $2, %eax\n pop %ecx\n add %ecx, %eax\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2*2
    codigo9:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n  mov $2, %eax\n pop %ecx\n imul %ecx, %eax\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2-2
    codigo10:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n  mov $2, %eax\n pop %ecx\n sub %ecx, %eax\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2/2
    codigo11:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n  cdq\n movl $2,%eax\n pop %ecx\n idivq %rcx\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2==2
    codigo12:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n pop %ecx\n cmp %eax,%ecx\n mov $0,%eax\n sete %al ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2!=2
    codigo13:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n movl $2,%eax\n pop %ecx\n cmp %eax,%ecx\n movl $0,%eax,setne %al\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2<2
    codigo14:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n movl $2,%eax\n pop %ecx\n cmp %eax,%ecx\n movl $0,%eax,setl %al\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2<=2
    codigo15:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n movl $2,%eax\n pop %ecx\n cmp %eax,%ecx\n movl $0,%eax,setle %al\n ret
       .section	.note.GNU-stack,"",@progbits

    """,#---return 2>2
    codigo16:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n movl $2,%eax\n pop %ecx\n cmp %eax,%ecx\n movl $0,%eax,setg %al\n ret
       .section	.note.GNU-stack,"",@progbits

    """#---return 2>=2
    codigo17:"""
        .section	.text.startup,"ax",@progbits\n    .p2align 4\n    .globl  main
    main:\n    endbr64\n    movl  $2, %eax\n push %eax\n movl $2,%eax\n pop %ecx\n cmp %eax,%ecx\n movl $0,%eax,setge %al\n ret
       .section	.note.GNU-stack,"",@progbits

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
      assert "int\nmain\n()\n{return 2;}"
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() ==
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

  #------ Pruebas parte 2 -------
  test "Operador negation", state do
    code = """
    int main() {
      return -2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo3]
  end

  test "Operador bitwise complement", state do
    code = """
    int main() {
      return ~2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo4]
  end

  test "Operador logical negation", state do
    code = """
    int main() {
      return !2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo5]
  end

  test "Multiples operadores", state do
    code = """
    int main() {
      return -~!2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo6]
  end

  test "Multiples operadores 2", state do
    code = """
    int main() {
      return !~-2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo7]
  end

#------ Pruebas parte 3 -------

  test "Suma 2+2", state do
    code = """
    int main() {
      return 2+2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo8]
  end

  test "Suma 2*2", state do
    code = """
    int main() {
      return 2*2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo9]
  end

  test "resta 2-2", state do
    code = """
    int main() {
      return 2-2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo10]
  end

  test "Division 2/2", state do
    code = """
    int main() {
      return 2/2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo11]
  end

  #------ Pruebas parte 4 -------


  test "Equal 2=2", state do
    code = """
    int main() {
      return 2=2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo12]
  end

  test "Not Equal 2!=2", state do
    code = """
    int main() {
      return 2!=2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo13]
  end

  test "Less 2<2", state do
    code = """
    int main() {
      return 2<2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo14]
  end

  test "Less equal 2<=2", state do
    code = """
    int main() {
      return 2<=2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo15]
  end

  test "Great 2>2", state do
    code = """
    int main() {
      return 2>2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo16]
  end

  test "Great Equal 2>=2", state do
    code = """
    int main() {
      return 2>=2;
    }
    """
    assert code
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() == state[:codigo17]
  end









end

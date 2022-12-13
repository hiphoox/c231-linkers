defmodule CodeGenerator do
  def generate_code(ast) do
    code = post_order(ast)
    #IO.puts("\nCode Generator output:")
    #IO.puts(code)
    code
  end

  def post_order(node) do
    case node do
      nil ->
        nil

      ast_node ->
        code_snippet = post_order(ast_node.left_node)
        # TODO: Falta terminar de implementar cuando el arbol tiene mas ramas
        post_order(ast_node.right_node)
        emit_code(ast_node.node_name, code_snippet, ast_node.value)
    end
  end

  def emit_code(:program, code_snippet, _) do
    """
        .section	.text.startup,"ax",@progbits
        .p2align 4
    """ <>
      code_snippet
  end

  def emit_code(:function, code_snippet, :main) do
    """
        .globl  main
    main:
    """ <>
      code_snippet
  end

  def emit_code(:return, code_snippet, _) do
    """
        endbr64
        movl    #{code_snippet}, %eax
        ret
        .section	.note.GNU-stack,"",@progbits

    """
  end

  def emit_code(:constant, _code_snippet, value) do
    "$#{value}"
  end
end

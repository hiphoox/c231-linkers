defmodule CodeGenerator do
  def generate_code(ast) do
    if is_map(ast) do
      code = post_order(ast)
      code
    else
      IO.inspect(ast)
      "Error"
    end
  end

  def post_order(node) do
    case node do
      nil ->
        nil

      ast_node ->
        code_snippet = post_order(ast_node.left_node)
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
        endbr64
    """ <>
      code_snippet
  end

  def emit_code(:return, code_snippet, _) do
    code_snippet<>
    """
        ret
        .section	.note.GNU-stack,"",@progbits

    """
  end

  def emit_code(:negation, code_snippet, _) do
    code_snippet<>
    """
        neg	%eax
    """
  end
  def emit_code(:bitwise_complement, code_snippet, _) do
    code_snippet<>
    """
        not	%eax
    """
  end
  def emit_code(:logical_negation, code_snippet, _) do
    code_snippet<>
    """
        cmpl     $0, %eax
        movl     $0, %eax
        sete     %al
    """
  end

  def emit_code(:constant, _code_snippet, value) do
    """
        movl  $#{value}, %eax
    """
  end
end

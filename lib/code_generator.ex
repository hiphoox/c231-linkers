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
        code_snippet2 = post_order(ast_node.right_node)
        emit_code(ast_node.node_name, code_snippet, code_snippet2, ast_node.value)

    end
  end

  def emit_code(:program, code_snippet, _, _) do
    """
        .section	.text.startup,"ax",@progbits
        .p2align 4
    """ <>
      code_snippet
  end

  def emit_code(:function, code_snippet, _, :main) do
    """
        .globl  main
    main:
        endbr64
    """ <>
      code_snippet
  end

  def emit_code(:return, code_snippet, _, _) do
    code_snippet<>
    """
        ret
        .section	.note.GNU-stack,"",@progbits

    """
  end

  def emit_code(:negation, code_snippet, nil, _) do
    code_snippet<>
    """
        neg	%rax
    """
  end
  def emit_code(:bitwise_complement, code_snippet, _, _) do
    code_snippet<>
    """
        not	%rax
    """
  end

  def emit_code(:logical_negation, code_snippet, _, _) do
    code_snippet<>
    """
        cmpq $0, %rax
        mov $0, %rax
        sete %al
    """
  end

  def emit_code(:constant, _code_snippet, _, value) do
    """
        mov $#{value}, %rax
    """
  end

  def emit_code(:addition, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        addq %rcx, %rax
    """
  end

  def emit_code(:multiplication, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        imul %rcx, %rax
    """
  end

  def emit_code(:negation, code_snippet, code_snippet2, _) do
    code_snippet2<>
    """
        pushq %rax
    """
    <>code_snippet<>
    """
        popq %rcx
        subq %rcx, %rax
    """
  end

  def emit_code(:division, code_snippet, code_snippet2, _) do
    code_snippet2<>
    """
        pushq %rax
    """
    <>code_snippet<>
    """
        popq %rcx
        idiv %rcx
    """
  end

  def emit_code(:equal, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        cmpq %rax, %rcx
        mov $0, %rax
        sete %al
    """
  end

  def emit_code(:not_equal, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        cmpq %rax, %rcx
        mov $0, %rax
        setne %al
    """
  end

  def emit_code(:greater_than_or_equal, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        cmpq %rax, %rcx
        mov $0, %rax
        setge %al
    """
  end

  def emit_code(:less_than_or_equal, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        cmpq %rax, %rcx
        mov $0, %rax
        setle %al
    """
  end

  def emit_code(:less_than, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        cmpq %rax, %rcx
        mov $0, %rax
        setl %al
    """
  end

  def emit_code(:greater_than, code_snippet, code_snippet2, _) do
    code_snippet<>
    """
        pushq %rax
    """
    <>code_snippet2<>
    """
        popq %rcx
        cmpq %rax, %rcx
        mov $0, %rax
        setg %al
    """
  end

  def emit_code(:or, code_snippet, code_snippet2, _) do
    n = Enum.random(1..2_000)
    clause = Enum.random(1..2_000)

    code_snippet<>
    """
        cmpl $0, %eax
        je _clause#{clause}
        movl $1, %eax
        jmp _end#{n}
        _clause#{clause}:
    """
    <>code_snippet2<>
    """
        cmpl $0, %eax
        movl $0, %eax
        setne %al
        _end#{n}:
    """
  end

  def emit_code(:and, code_snippet, code_snippet2, _) do
    n = Enum.random(1..2_000)
    clause = Enum.random(1..2_000)

    code_snippet<>
    """
        cmpl $0, %eax
        jne _clause#{clause}
        jmp _end#{n}
        _clause#{clause}:
    """
    <>code_snippet2<>
    """
        cmpl $0, %eax
        movl $0, %eax
        setne %al
        _end#{n}:
    """
  end

end

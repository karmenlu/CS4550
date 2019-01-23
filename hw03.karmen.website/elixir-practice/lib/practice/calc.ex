defmodule Practice.Calc do
  def parse_float(text) do
    case Float.parse(text) do
       {num, _} -> num
       _ -> 0
    end
  end

  def tok_to_kv(tok) do
    cond do
      tok == "+" || tok == "-" || tok == "*" || tok == "/" -> {:op, tok}
      true -> {:num, parse_float(tok)}
    end
  end

  def tag_tokens(list) do
    Enum.map(list, &tok_to_kv/1)
  end

  # Mini shunting-yard algorithm
  
  def operator_prec(tok) do
    cond do
      tok == "+" -> 1
      tok == "-" -> 1
      tok == "*" -> 2
      tok == "/" -> 2
      true -> 0
    end
  end    

  def second(list) do
    hd(tl(list))
  end

  def operatorhuh(op) do
    cond do
      op == "+" -> true
      op == "*" -> true
      op == "-" -> true
      op == "/" -> true
      true -> false
    end
  end

  def apply_op(stack, op) do
    sec = second(stack)
    fr = hd(stack)
    rr = tl(tl(stack))
    cond do
      op == "+" -> [sec + fr | rr]
      op == "*" -> [sec * fr | rr]
      op == "-" -> [sec - fr | rr]
      op == "/" -> [sec / fr | rr]
    end
  end

  def calc2([], [ans_head | _ans_tail], []) do
    ans_head
  end

  def calc2([], answer_stack, [op_head | op_tail]) do
    calc2([], apply_op(answer_stack, op_head), op_tail)
  end

  def calc2([inp_head | inp_tail], answer_stack, op_stack) do
    if not operatorhuh(inp_head) do
      calc2(inp_tail, [parse_float(inp_head) | answer_stack], op_stack)
    else
      if length(op_stack) == 0 || operator_prec(hd(op_stack)) < operator_prec(inp_head) do
        calc2(inp_tail, answer_stack, [inp_head | op_stack])
      else
        calc2([inp_head | inp_tail], apply_op(answer_stack, hd(op_stack)), tl(op_stack))
      end
    end
  end

  def calc2(input) do
    calc2(input, [], [])
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> calc2
  end
end


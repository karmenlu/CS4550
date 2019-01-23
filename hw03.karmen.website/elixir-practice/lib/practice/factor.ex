defmodule Practice.Factor do
  
  def parse_int(x) when is_integer(x) do
    x
  end

  def parse_int(text) do
    case Integer.parse(text) do
      {num, _} -> num
      _ -> 0
    end
  end
  
  def factor(x) do
    if x == "" do
      "No input provided"
    else 
      x = parse_int(x)
      if x <= 1 do
        "Enter a number > 1"
      else
        factor(parse_int(x), [])
      end
    end
  end

  def factor(x, acc_list) do
    if x == 1 do
      acc_list
    else
      y = factor_one(x, 2)
      factor(div(x, y), acc_list ++ [y])
    end
  end

  def factor_one(x, acc) do
    if acc == x do
      x
    else
      if rem(x, acc) == 0 do
        acc
      else
        factor_one(x, acc + 1)
      end
    end
  end
end


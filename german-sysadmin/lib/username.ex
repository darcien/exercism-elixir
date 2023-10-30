defmodule Username do
  def sanitize(~c"") do
    ~c""
  end

  def sanitize([head | tail]) do
    sanitized =
      case(head) do
        char when char >= ?a and char <= ?z -> [char]
        ?_ -> ~c"_"
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        _ -> ~c""
      end

    sanitized ++ sanitize(tail)
  end
end

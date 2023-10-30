defmodule NameBadge do
  def print(id, name, department) do
    id_part = if id, do: "[#{id}]", else: nil
    dep_part = if department, do: String.upcase(department), else: "OWNER"

    [id_part, "#{name}", dep_part]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(" - ")
  end
end

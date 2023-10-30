defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[^a-zA-Z0-9 \-]/, "")
    |> String.split(~r/ |\-/, trim: true)
    |> Enum.map(fn word ->
      word
      |> String.at(0)
      |> String.upcase()
    end)
    |> Enum.join()
  end
end

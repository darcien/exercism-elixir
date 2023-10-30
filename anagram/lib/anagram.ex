defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_lowercase = String.downcase(base)
    base_alphabet_map = string_to_alphabet_map(base)

    candidates
    |> Enum.filter(fn candidate ->
      String.downcase(candidate) != base_lowercase and
        anagram?(base_alphabet_map, candidate)
    end)
  end

  defp anagram?(base_map, candidate) do
    Map.equal?(base_map, string_to_alphabet_map(candidate))
  end

  defp string_to_alphabet_map(string) do
    string
    |> String.downcase()
    |> String.split("")
    |> Enum.reduce(%{}, fn alphabet, acc ->
      Map.put(acc, alphabet, Map.get(acc, alphabet, 0) + 1)
    end)
  end
end

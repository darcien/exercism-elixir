defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map_join(" ", &translate_word/1)
  end

  defp translate_word(word) do
    case Regex.run(~r/^([^aiueo]+)/, word) do
      [_, consonants] ->
        remainder = remove_string_head(word, consonants)

        cond do
          String.length(consonants) > 1 and String.starts_with?(consonants, ["x", "y"]) ->
            word <> "ay"

          String.length(consonants) > 1 and
              String.contains?(consonants, "y") ->
            [consonants_without_y, remainder_without_y] = String.split(consonants, "y", parts: 2)
            "y" <> remainder_without_y <> consonants_without_y <> "ay"

          String.ends_with?(consonants, "q") and String.starts_with?(remainder, "u") ->
            remove_string_head(remainder, "u") <> consonants <> "uay"

          true ->
            remainder <> consonants <> "ay"
        end

      _ ->
        word <> "ay"
    end
  end

  defp remove_string_head(word, head) do
    String.slice(word, String.length(head)..-1)
  end
end

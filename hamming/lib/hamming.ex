defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2)
      when length(strand1) == length(strand2) do
    distance =
      Enum.zip_reduce(strand1, strand2, 0, fn c1, c2, acc ->
        if c1 != c2, do: acc + 1, else: acc
      end)

    {:ok, distance}
  end

  def hamming_distance(_, _) do
    {:error, "strands must be of equal length"}
  end
end

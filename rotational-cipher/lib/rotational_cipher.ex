defmodule RotationalCipher do
  @alphabet_count 26

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(fn codepoint -> rotate_codepoint(codepoint, shift) end)
    |> to_string()
  end

  defp rotate_codepoint(codepoint, shift) when codepoint >= ?A and codepoint <= ?Z do
    do_rotate_codepoint(codepoint, shift, ?A)
  end

  defp rotate_codepoint(codepoint, shift) when codepoint >= ?a and codepoint <= ?z do
    do_rotate_codepoint(codepoint, shift, ?a)
  end

  defp rotate_codepoint(other_codepoint, _shift) do
    other_codepoint
  end

  defp do_rotate_codepoint(codepoint, shift, codepoint_offset) do
    codepoint
    |> Kernel.-(codepoint_offset)
    |> Kernel.+(shift)
    |> Integer.mod(@alphabet_count)
    |> Kernel.+(codepoint_offset)
  end
end

defmodule DNA do
  @nucleotide_bit_size 4

  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], encoded) do
    encoded
  end

  defp do_encode([nucleotide | tail], encoded) do
    do_encode(
      tail,
      <<encoded::bitstring, encode_nucleotide(nucleotide)::size(@nucleotide_bit_size)>>
    )
  end

  def decode(encoded_dna) do
    do_decode(encoded_dna, [])
  end

  defp do_decode(<<>>, decoded) do
    decoded
  end

  defp do_decode(
         <<encoded_nucleotide::size(@nucleotide_bit_size), rest_of_encoded_dna::bitstring>>,
         decoded
       ) do
    do_decode(rest_of_encoded_dna, decoded ++ [decode_nucleotide(encoded_nucleotide)])
  end
end

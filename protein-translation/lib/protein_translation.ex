defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    result =
      rna
      |> String.split("", trim: true)
      |> Stream.chunk_every(3)
      |> Stream.map(&Enum.join/1)
      |> Stream.map(&of_codon/1)
      |> Enum.reduce_while({:ok, []}, fn el, {_, translated} ->
        case el do
          {:error, _} -> {:halt, {:error, "invalid RNA"}}
          {_, "STOP"} -> {:halt, {:ok, translated}}
          {_, codon} -> {:cont, {:ok, [codon | translated]}}
        end
      end)

    case result do
      {:error, _} -> result
      {_, reversed} -> {:ok, Enum.reverse(reversed)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) when codon == "AUG" do
    {:ok, "Methionine"}
  end

  def of_codon(codon) when codon == "UGG" do
    {:ok, "Tryptophan"}
  end

  def of_codon(codon) when codon in ["UUU", "UUC"] do
    {:ok, "Phenylalanine"}
  end

  def of_codon(codon) when codon in ["UUA", "UUG"] do
    {:ok, "Leucine"}
  end

  def of_codon(codon) when codon in ["UCU", "UCC", "UCA", "UCG"] do
    {:ok, "Serine"}
  end

  def of_codon(codon) when codon in ["UAU", "UAC"] do
    {:ok, "Tyrosine"}
  end

  def of_codon(codon) when codon in ["UGU", "UGC"] do
    {:ok, "Cysteine"}
  end

  def of_codon(codon) when codon in ["UAA", "UAG", "UGA"] do
    {:ok, "STOP"}
  end

  def of_codon(_codon) do
    {:error, "invalid codon"}
  end
end

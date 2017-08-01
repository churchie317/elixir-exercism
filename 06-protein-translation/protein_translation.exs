defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna
      |> String.codepoints
      |> Enum.chunk(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.reverse
      |> Enum.reduce({ :ok, [] }, &amino_acids_to_protein/2)
      |> handle_protein
  end

  defp amino_acids_to_protein(triplet, protein) do
    with { :ok, amino_acids } <- protein,
         { :ok, amino_acid } <- of_codon(triplet),
         do: { :ok, [ amino_acid | amino_acids ] }
  end

  defp handle_protein(msg) do
    case msg do
      { :ok, amino_acids } ->
        truncate_protein = amino_acids
          |> Enum.take_while(fn amino_acid -> amino_acid !== "STOP" end)
        { :ok, truncate_protein }
      { :error, _ } ->
        { :error, "invalid RNA" }
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    proteins = %{
      "UGU" => "Cysteine",
      "UGC" => "Cysteine",
      "UUA" => "Leucine",
      "UUG" => "Leucine",
      "AUG" => "Methionine",
      "UUU" => "Phenylalanine",
      "UUC" => "Phenylalanine",
      "UCU" => "Serine",
      "UCC" => "Serine",
      "UCA" => "Serine",
      "UCG" => "Serine",
      "UGG" => "Tryptophan",
      "UAU" => "Tyrosine",
      "UAC" => "Tyrosine",
      "UAA" => "STOP",
      "UAG" => "STOP",
      "UGA" => "STOP"
    }

    proteins
    |> Map.get(codon)
    |> to_message
  end

  defp to_message(amino_acid) do
    case amino_acid do
      nil ->
        { :error, "invalid codon" }
      _ ->
        { :ok, amino_acid }
    end
  end

end


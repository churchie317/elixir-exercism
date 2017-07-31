defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&(rotate_char(&1, shift))) 
    |> to_string
  end

  defp rotate_char(char, shift) when char >= 65 and char <= 90 do
    rem(char - 65 + shift, 26) + 65
  end

  defp rotate_char(char, shift) when char >= 97 and char <= 122 do
    rem(char - 97 + shift, 26) + 97
  end

  defp rotate_char(char, _shift) do
    char
  end

end


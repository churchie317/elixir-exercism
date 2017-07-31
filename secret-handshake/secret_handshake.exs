defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> jump(code)
    |> close_your_eyes(code)
    |> double_blink(code)
    |> wink(code) 
    |> reverse(code)
  end

  defp wink(handshake, code) do
    case code &&& 0b1 do
      0b1 -> 
        [ "wink" | handshake ]
      _ -> 
        handshake
    end 
  end

  defp double_blink(handshake, code) do
    case code &&& 0b10 do
      0b10 -> 
        [ "double blink" | handshake ]
      _ -> 
        handshake
    end
  end

  defp close_your_eyes(handshake, code) do
    case code &&& 0b100 do
      0b100 -> 
        [ "close your eyes" | handshake ]

      _ -> 
        handshake
    end
  end

  defp jump(handshake, code) do
    case code &&& 0b1000 do
      0b1000 -> 
        [ "jump" | handshake ]

      _ -> 
        handshake
    end
  end
  
  defp reverse(handshake, code) do
    case code &&& 0b10000 do
      0b10000 -> 
        Enum.reverse handshake

      _ -> 
        handshake
    end
  end

end


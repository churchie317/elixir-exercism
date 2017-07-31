defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    keep(Enum.reverse(list), fun, [])
  end

  defp keep([ item | rest ], fun, collection) do
    if fun.(item) do
      keep(rest, fun, [ item | collection ])
    else
      keep(rest, fun, collection)
    end
  end

  defp keep([], _fun, collection) do
    collection
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    discard(Enum.reverse(list), fun, [])
  end

  defp discard([ item | rest ], fun, collection) do
    if not fun.(item) do
      discard(rest, fun, [ item | collection ])
    else
      discard(rest, fun, collection)
    end
  end

  defp discard([], _fun, collection) do
    collection
  end
end

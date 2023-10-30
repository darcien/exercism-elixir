defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_keep(list, fun, [])
  end

  defp do_keep([], _fun, keeped) do
    keeped
  end

  defp do_keep([head | rest], fun, keeped) do
    if fun.(head) do
      do_keep(rest, fun, keeped ++ [head])
    else
      do_keep(rest, fun, keeped)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_discard(list, fun, [])
  end

  defp do_discard([], _fun, keeped) do
    keeped
  end

  defp do_discard([head | rest], fun, keeped) do
    if fun.(head) do
      do_discard(rest, fun, keeped)
    else
      do_discard(rest, fun, keeped ++ [head])
    end
  end
end

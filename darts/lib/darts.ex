defmodule Darts do
  @type position :: {number, number}

  defp pos_to_distance_from_center({x, y}), do: (x ** 2 + y ** 2) |> Kernel.**(0.5)

  defp distance_to_score(distance) when distance <= 1, do: 10
  defp distance_to_score(distance) when distance <= 5, do: 5
  defp distance_to_score(distance) when distance <= 10, do: 1
  defp distance_to_score(_), do: 0

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(pos) do
    pos |> pos_to_distance_from_center() |> distance_to_score()
  end
end

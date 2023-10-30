defmodule Lasagna do
  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(t), do: expected_minutes_in_oven() - t

  def preparation_time_in_minutes(layer), do: layer * 2

  def total_time_in_minutes(layer, t),
    do: preparation_time_in_minutes(layer) + t

  def alarm, do: "Ding!"
end

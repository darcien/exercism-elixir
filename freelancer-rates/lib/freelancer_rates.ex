defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100
  end

  defp daily_rate_discounted(hourly_rate, discount) do
    daily_rate(hourly_rate) |> apply_discount(discount)
  end

  def monthly_rate(hourly_rate, discount) do
    (daily_rate_discounted(hourly_rate, discount) * 22) |> Float.ceil() |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    (budget / daily_rate_discounted(hourly_rate, discount)) |> Float.floor(1)
  end
end

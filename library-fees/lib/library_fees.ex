defmodule LibraryFees do
  def datetime_from_string(string) do
    case NaiveDateTime.from_iso8601(string) do
      {:ok, date} -> date
    end
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    leeway_day_count = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(leeway_day_count)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    day = datetime |> NaiveDateTime.to_date() |> Date.day_of_week()
    # 1 is Monday
    day == 1
  end

  defp do_calculate_fee(days, daily_rate) do
    days * daily_rate
  end

  def calculate_late_fee(checkout, return, rate) do
    supposed_return_date =
      checkout
      |> datetime_from_string()
      |> return_date()

    actual_return_datetime = datetime_from_string(return)

    days_late = days_late(supposed_return_date, actual_return_datetime)
    fee = do_calculate_fee(days_late, rate)
    if monday?(actual_return_datetime), do: Integer.floor_div(fee, 2), else: fee
  end
end

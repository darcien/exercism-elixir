defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    # 1000 <= x <= 9999
    # 1 <= x - 999 <= 9000
    # using Erlang
    # number_part = :rand.uniform(9000) + 999
    # using Elixir range
    number_part = Enum.random(1000..9999)
    "NCC-#{number_part}"
  end

  def random_stardate() do
    # 41000.0 <= x < 42000.0
    :rand.uniform() * 1000 + 41000
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> IO.iodata_to_binary()
  end
end

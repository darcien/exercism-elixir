defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(fn item -> item[:price] end, :asc)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(fn item -> item[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
      %{item | name: String.replace(item[:name], old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    %{
      item
      | quantity_by_size:
          Map.new(item[:quantity_by_size], fn
            {size, old_count} -> {size, old_count + count}
          end)
    }
  end

  def total_quantity(item) do
    # item[:quantity_by_size]
    # |> Map.values()
    # |> Enum.sum()

    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_size, quantity}, acc -> quantity + acc end)
  end
end

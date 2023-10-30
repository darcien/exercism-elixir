defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(object, subject)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_bread, subject) when is_struct(subject, Character) do
      {nil, %{subject | health: subject.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(mana_potion, subject) when is_struct(subject, Character) do
      {%EmptyBottle{}, %{subject | mana: subject.mana + mana_potion.strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_poison, subject) when is_struct(subject, Character) do
      {%EmptyBottle{}, %{subject | health: 0}}
    end
  end
end

defmodule Charsheet.CoreStatsTest do
  use Charsheet.ModelCase

  alias Charsheet.CoreStats

  @valid_attrs %{charisma: 20, constitution: 1, dexterity: 11, intelligence: 15, strength: 18, wisdom: 5}
  @invalid_attrs %{charisma: -1, constitution: 0, dexterity: -5, intelligence: -3, strength: 29, wisdom: 21}

  test "changeset with valid attributes" do
    changeset = CoreStats.changeset(%CoreStats{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CoreStats.changeset(%CoreStats{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule Charsheet.CoreStatsTest do
  use Charsheet.ModelCase

  alias Charsheet.CoreStats

  @valid_attrs %{charisma: 42, constitution: 42, dexterity: 42, intelligence: 42, strength: 42, wisdom: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CoreStats.changeset(%CoreStats{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CoreStats.changeset(%CoreStats{}, @invalid_attrs)
    refute changeset.valid?
  end
end

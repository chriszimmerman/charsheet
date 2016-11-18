defmodule Charsheet.CharacterTest do
  use Charsheet.ModelCase

  alias Charsheet.Character

  @valid_attrs %{name: "some content", hit_points: 9, level: 1, experience_points: 0, strength: 10, dexterity: 11, constitution: 12, intelligence: 13, wisdom: 14, charisma: 15}
  @invalid_attrs %{hit_points: 0, strength: -1, dexterity: -1, constitution: -2, intelligence: -3, wisdom: -4, charisma: -5}

  test "changeset with valid attributes" do
    changeset = Character.changeset(%Character{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Character.changeset(%Character{}, @invalid_attrs)
    refute changeset.valid?
  end
end

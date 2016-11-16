defmodule Charsheet.CharacterTest do
  use Charsheet.ModelCase

  alias Charsheet.Character

  @valid_attrs %{name: "some content", strength: 10, dexterity: 11, constitution: 12, intelligence: 13, wisdom: 14, charisma: 15}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Character.changeset(%Character{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Character.changeset(%Character{}, @invalid_attrs)
    refute changeset.valid?
  end
end

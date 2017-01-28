defmodule Charsheet.CalculationsTest do
  use Charsheet.ModelCase

  alias Charsheet.Character
  alias Charsheet.Calculations

  test "A level 1 character should have a proficiency bonus of 2" do
    character = %Character{ level: 1}
    result = Calculations.proficiency_bonus(character)
    expected = 2
    assert(expected == result)
  end

  test "A level 5 character should have a proficiency bonus of 3" do
    character = %Character{ level: 5}
    result = Calculations.proficiency_bonus(character)
    expected = 3
    assert(expected == result)
  end
end

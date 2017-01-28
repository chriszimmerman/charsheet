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

  test "An ability score returns the right modifier" do
    maps = [
      %{score: 1, modifier:  -5},
      %{score: 2, modifier: -4},
      %{score: 3, modifier: -4},
      %{score: 4, modifier: -3},
      %{score: 5, modifier: -3},
      %{score: 6, modifier: -2},
      %{score: 7, modifier: -2},
      %{score: 8, modifier: -1},
      %{score: 9, modifier: -1},
      %{score: 10, modifier: 0},
      %{score: 11, modifier: 0},
      %{score: 12, modifier: 1},
      %{score: 13, modifier: 1},
      %{score: 14, modifier: 2},
      %{score: 15, modifier: 2},
      %{score: 16, modifier: 3},
      %{score: 17, modifier: 3},
      %{score: 18, modifier: 4},
      %{score: 19, modifier: 4},
      %{score: 20, modifier: 5}
    ]

    Enum.each(maps, fn map -> 
      result = Calculations.modifier(map[:score])
      expected = map[:modifier]
      assert(expected == result)
    end)
  end
end

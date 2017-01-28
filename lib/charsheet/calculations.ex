defmodule Charsheet.Calculations do
  def proficiency_bonus(character) do
    1 + round(Float.ceil(character.level / 4))
  end

end

defmodule Charsheet.Character do
  use Charsheet.Web, :model

  schema "characters" do
    field :name, :string
		field :class, :string
		field :level, :integer
		field :race, :string
		field :background, :string
		field :alignment, :string
		field :experience_points, :integer
		field :hit_points, :integer
    field :strength, :integer
    field :dexterity, :integer
    field :constitution, :integer
    field :intelligence, :integer
    field :wisdom, :integer
    field :charisma, :integer
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :class, :race, :background, :alignment, :hit_points, :level, :experience_points, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma])
    |> validate_required([:name, :hit_points, :level, :experience_points, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma])
    |> validate_inclusion(:strength, 1..20)
    |> validate_inclusion(:dexterity, 1..20)
    |> validate_inclusion(:constitution, 1..20)
    |> validate_inclusion(:intelligence, 1..20)
    |> validate_inclusion(:wisdom, 1..20)
    |> validate_inclusion(:charisma, 1..20)
    |> validate_number(:hit_points, greater_than: 0)
    |> validate_number(:level, greater_than: 0)
    |> validate_number(:experience_points, greater_than_or_equal_to: 0)
  end
end

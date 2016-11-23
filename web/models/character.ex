defmodule Charsheet.Character do
  use Charsheet.Web, :model
  alias Charsheet.CoreStats

  schema "characters" do
    field :name, :string
	field :class, :string
	field :level, :integer
	field :race, :string
	field :background, :string
	field :alignment, :string
	field :experience_points, :integer
	field :hit_points, :integer
	embeds_one(:core_stats, Charsheet.CoreStats, on_replace: :delete)

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :class, :race, :background, :alignment, :hit_points, :level, :experience_points])
    |> validate_required([:name, :hit_points, :level, :experience_points])
    |> validate_number(:hit_points, greater_than: 0)
    |> validate_number(:level, greater_than: 0)
    |> validate_number(:experience_points, greater_than_or_equal_to: 0)
  end
end

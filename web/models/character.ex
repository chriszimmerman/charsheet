defmodule Charsheet.Character do
  use Charsheet.Web, :model

  schema "characters" do
    field :name, :string
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
    |> cast(params, [:name, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma])
    |> validate_required([:name, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma])
    |> validate_inclusion(:strength, 1..20)
    |> validate_inclusion(:dexterity, 1..20)
    |> validate_inclusion(:constitution, 1..20)
    |> validate_inclusion(:intelligence, 1..20)
    |> validate_inclusion(:wisdom, 1..20)
    |> validate_inclusion(:charisma, 1..20)
  end
end

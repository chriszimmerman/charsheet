defmodule Charsheet.Repo.Migrations.AddHpAndDescriptiveAttributes do
  use Ecto.Migration

  def change do
		alter table(:characters) do
			add :hit_points, :integer
			add :level, :integer
			add :class, :string
			add :race, :string
			add :background, :string
			add :alignment, :string
			add :experience_points, :integer
		end
  end
end

defmodule Charsheet.Repo.Migrations.CreateCoreStats do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      remove :strength
      remove :dexterity
      remove :constitution
      remove :intelligence
      remove :wisdom
      remove :charisma

			add :core_stats, :map
    end

  end
end

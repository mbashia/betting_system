defmodule BettingSystem.Repo.Migrations.CreateSports do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :name, :string
      add :description, :string
      add :active, :string, default: ""
      add :user_id, :integer

      timestamps()
    end

    create index(:sports, [:user_id])
  end
end

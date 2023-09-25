defmodule BettingSystem.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :sport_id, :integer
      add :date, :naive_datetime
      add :status, :string
      add :result, :string
      add :location, :string
      add :win, :float
      add :draw, :float
      add :lose, :float
      add :team1, :string
      add :team2, :string
      add :user_id, :integer

      timestamps()
    end

    create index(:games, [:sport_id])
  end
end

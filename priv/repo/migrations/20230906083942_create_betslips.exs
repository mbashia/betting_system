defmodule BettingSystem.Repo.Migrations.CreateBetslips do
  use Ecto.Migration

  def change do
    create table(:betslips) do
      add :status, :string, default: "in_betslip"
      add :odds, :float
      add :result_type, :string
      add :game_id, :integer
      add :user_id, :integer
      add :end_result, :string, default: "nothing"

      timestamps()
    end
  end
end

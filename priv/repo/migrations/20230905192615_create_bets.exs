defmodule BettingSystem.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :amount, :integer
      add :odds, :float
      add :status, :string, default: "open"
      add :payout, :float, default: 0.0
      add :user_id, :integer
      add :bet_items, {:map, :integer}
      add :end_result, :string, default: "nothing"
      add :bet_id, :string

      timestamps()
    end

    create index(:bets, [:user_id])
  end
end

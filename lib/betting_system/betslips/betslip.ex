defmodule BettingSystem.Betslips.Betslip do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Games.Game
  alias BettingSystem.Accounts.User

  schema "betslips" do
    field :odds, :float
    field :result_type, :string
    field :status, :string, default: "in_betslip"
    field :end_result, :string, default: "nothing"
    belongs_to :game, Game, foreign_key: :game_id
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(betslip, attrs) do
    betslip
    |> cast(attrs, [:status, :odds, :result_type, :game_id, :user_id, :end_result])
    |> validate_required([:status, :odds, :result_type, :game_id, :user_id, :end_result])
  end
end

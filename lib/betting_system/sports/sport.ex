defmodule BettingSystem.Sports.Sport do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Accounts.User
  alias BettingSystem.Games.Game

  schema "sports" do
    field :description, :string
    field :name, :string
    field :active, :string
    belongs_to :user, User, foreign_key: :user_id
    has_many :games, Game

    timestamps()
  end

  @doc false
  def changeset(sport, attrs) do
    sport
    |> cast(attrs, [:name, :description, :active, :user_id])
    |> validate_required([:name, :description, :active, :user_id])
  end
end

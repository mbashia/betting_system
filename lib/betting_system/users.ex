defmodule BettingSystem.Users do
  import Ecto.Query, warn: false
  alias BettingSystem.Repo

  alias BettingSystem.Accounts.User

  def list_users() do
    Repo.all(User)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.change_user_changeset(user, attrs)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def update_user(%User{} = user, attrs) do
    user
    |> User.change_user_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end

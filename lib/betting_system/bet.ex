defmodule BettingSystem.Bet do
  @moduledoc """
  The Bet context.
  """

  import Ecto.Query, warn: false
  alias BettingSystem.Repo

  alias BettingSystem.Bet.Bets

  @doc """
  Returns the list of bets.

  ## Examples

      iex> list_bets()
      [%Bets{}, ...]

  """

  def get_all_bets(id) do
    Repo.all(from b in Bets, where: b.user_id == ^id)
  end

  def list_bets do
    Repo.all(Bets)
  end

  @doc """
  Gets a single bets.

  Raises `Ecto.NoResultsError` if the Bets does not exist.

  ## Examples

      iex> get_bets!(123)
      %Bets{}

      iex> get_bets!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bets!(id), do: Repo.get!(Bets, id)

  @doc """
  Creates a bets.

  ## Examples

      iex> create_bets(%{field: value})
      {:ok, %Bets{}}

      iex> create_bets(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bets(attrs \\ %{}) do
    %Bets{}
    |> Bets.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bets.

  ## Examples

      iex> update_bets(bets, %{field: new_value})
      {:ok, %Bets{}}

      iex> update_bets(bets, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bets(%Bets{} = bets, attrs) do
    bets
    |> Bets.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bets.

  ## Examples

      iex> delete_bets(bets)
      {:ok, %Bets{}}

      iex> delete_bets(bets)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bets(%Bets{} = bets) do
    Repo.delete(bets)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bets changes.

  ## Examples

      iex> change_bets(bets)
      %Ecto.Changeset{data: %Bets{}}

  """
  def change_bets(%Bets{} = bets, attrs \\ %{}) do
    Bets.changeset(bets, attrs)
  end
end

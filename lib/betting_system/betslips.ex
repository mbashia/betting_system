defmodule BettingSystem.Betslips do
  @moduledoc """
  The Betslips context.
  """

  import Ecto.Query, warn: false
  alias BettingSystem.Repo

  alias BettingSystem.Betslips.Betslip

  @doc """
  Returns the list of betslips.

  ## Examples

      iex> list_betslips()
      [%Betslip{}, ...]

  """
  def list_betslips do
    Repo.all(Betslip)
  end

  def get_betslips(id) do
    Repo.all(from b in Betslip, where: b.user_id == ^id and b.status == "in_betslip")
    |> Repo.preload(:game)
  end

  def check_betslip!(id, game_id) do
    Repo.one(
      from b in Betslip,
        where: b.user_id == ^id and b.game_id == ^game_id and b.status == "in_betslip"
    )
  end

  def getting_betslip(id, game_id) do
    Repo.one(from b in Betslip, where: b.user_id == ^id and b.game_id == ^game_id)
  end

  def get_betslip_user_id(id) do
    Repo.all(from b in Betslip, where: b.user_id == ^id)
    |> Repo.preload(:game)
  end

  # def get_betslip_by_game_id(id, game_id)do
  #   Repo.one(from b in Betslip, where: b.user_id == ^id and b.game_id == ^game_id)

  # end

  @doc """
  Gets a single betslip.

  Raises `Ecto.NoResultsError` if the Betslip does not exist.

  ## Examples

      iex> get_betslip!(123)
      %Betslip{}

      iex> get_betslip!(456)
      ** (Ecto.NoResultsError)

  """
  def get_betslip!(id), do: Repo.get!(Betslip, id)

  @doc """
  Creates a betslip.

  ## Examples

      iex> create_betslip(%{field: value})
      {:ok, %Betslip{}}

      iex> create_betslip(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_betslip(attrs \\ %{}) do
    %Betslip{}
    |> Betslip.changeset(attrs)
    |> Repo.insert()
  end

  # @spec update_betslip(
  #         %BettingSystem.Betslips.Betslip{optional(atom) => any},
  #         :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
  #       ) :: any
  # @doc """
  # Updates a betslip.

  ## Examples

  # iex> update_betslip(betslip, %{field: new_value})
  # {:ok, %Betslip{}}

  # iex> update_betslip(betslip, %{field: bad_value})
  # {:error, %Ecto.Changeset{}}

  def update_betslip(%Betslip{} = betslip, attrs) do
    betslip
    |> Betslip.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a betslip.

  ## Examples

      iex> delete_betslip(betslip)
      {:ok, %Betslip{}}

      iex> delete_betslip(betslip)
      {:error, %Ecto.Changeset{}}

  """
  def delete_betslip(%Betslip{} = betslip) do
    Repo.delete(betslip)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking betslip changes.

  ## Examples

      iex> change_betslip(betslip)
      %Ecto.Changeset{data: %Betslip{}}

  """
  def change_betslip(%Betslip{} = betslip, attrs \\ %{}) do
    Betslip.changeset(betslip, attrs)
  end
end

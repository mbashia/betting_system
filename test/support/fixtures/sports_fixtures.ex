defmodule BettingSystem.SportsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BettingSystem.Sports` context.
  """

  @doc """
  Generate a sport.
  """
  def sport_fixture(attrs \\ %{}) do
    {:ok, sport} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> BettingSystem.Sports.create_sport()

    sport
  end
end

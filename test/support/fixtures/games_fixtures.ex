defmodule BettingSystem.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BettingSystem.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        date: ~N[2023-09-04 19:13:00],
        draw: 120.5,
        location: "some location",
        lose: 120.5,
        result: "some result",
        status: "some status",
        type: "some type",
        win: 120.5
      })
      |> BettingSystem.Games.create_game()

    game
  end
end

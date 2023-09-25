defmodule BettingSystem.BetFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BettingSystem.Bet` context.
  """

  @doc """
  Generate a bets.
  """
  def bets_fixture(attrs \\ %{}) do
    {:ok, bets} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        odds: 120.5,
        outcome: "some outcome",
        payout: 120.5,
        status: "some status"
      })
      |> BettingSystem.Bet.create_bets()

    bets
  end
end

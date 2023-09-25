defmodule BettingSystem.BetslipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BettingSystem.Betslips` context.
  """

  @doc """
  Generate a betslip.
  """
  def betslip_fixture(attrs \\ %{}) do
    {:ok, betslip} =
      attrs
      |> Enum.into(%{
        odds: 120.5,
        result_type: "some result_type",
        status: "some status"
      })
      |> BettingSystem.Betslips.create_betslip()

    betslip
  end
end

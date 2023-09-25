defmodule BettingSystem.BetTest do
  use BettingSystem.DataCase

  alias BettingSystem.Bet

  describe "bets" do
    alias BettingSystem.Bet.Bets

    import BettingSystem.BetFixtures

    @invalid_attrs %{amount: nil, odds: nil, outcome: nil, payout: nil, status: nil}

    test "list_bets/0 returns all bets" do
      bets = bets_fixture()
      assert Bet.list_bets() == [bets]
    end

    test "get_bets!/1 returns the bets with given id" do
      bets = bets_fixture()
      assert Bet.get_bets!(bets.id) == bets
    end

    test "create_bets/1 with valid data creates a bets" do
      valid_attrs = %{
        amount: 120.5,
        odds: 120.5,
        outcome: "some outcome",
        payout: 120.5,
        status: "some status"
      }

      assert {:ok, %Bets{} = bets} = Bet.create_bets(valid_attrs)
      assert bets.amount == 120.5
      assert bets.odds == 120.5
      assert bets.outcome == "some outcome"
      assert bets.payout == 120.5
      assert bets.status == "some status"
    end

    test "create_bets/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bet.create_bets(@invalid_attrs)
    end

    test "update_bets/2 with valid data updates the bets" do
      bets = bets_fixture()

      update_attrs = %{
        amount: 456.7,
        odds: 456.7,
        outcome: "some updated outcome",
        payout: 456.7,
        status: "some updated status"
      }

      assert {:ok, %Bets{} = bets} = Bet.update_bets(bets, update_attrs)
      assert bets.amount == 456.7
      assert bets.odds == 456.7
      assert bets.outcome == "some updated outcome"
      assert bets.payout == 456.7
      assert bets.status == "some updated status"
    end

    test "update_bets/2 with invalid data returns error changeset" do
      bets = bets_fixture()
      assert {:error, %Ecto.Changeset{}} = Bet.update_bets(bets, @invalid_attrs)
      assert bets == Bet.get_bets!(bets.id)
    end

    test "delete_bets/1 deletes the bets" do
      bets = bets_fixture()
      assert {:ok, %Bets{}} = Bet.delete_bets(bets)
      assert_raise Ecto.NoResultsError, fn -> Bet.get_bets!(bets.id) end
    end

    test "change_bets/1 returns a bets changeset" do
      bets = bets_fixture()
      assert %Ecto.Changeset{} = Bet.change_bets(bets)
    end
  end
end

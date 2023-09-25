defmodule BettingSystem.BetslipsTest do
  use BettingSystem.DataCase

  alias BettingSystem.Betslips

  describe "betslips" do
    alias BettingSystem.Betslips.Betslip

    import BettingSystem.BetslipsFixtures

    @invalid_attrs %{odds: nil, result_type: nil, status: nil}

    test "list_betslips/0 returns all betslips" do
      betslip = betslip_fixture()
      assert Betslips.list_betslips() == [betslip]
    end

    test "get_betslip!/1 returns the betslip with given id" do
      betslip = betslip_fixture()
      assert Betslips.get_betslip!(betslip.id) == betslip
    end

    test "create_betslip/1 with valid data creates a betslip" do
      valid_attrs = %{odds: 120.5, result_type: "some result_type", status: "some status"}

      assert {:ok, %Betslip{} = betslip} = Betslips.create_betslip(valid_attrs)
      assert betslip.odds == 120.5
      assert betslip.result_type == "some result_type"
      assert betslip.status == "some status"
    end

    test "create_betslip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Betslips.create_betslip(@invalid_attrs)
    end

    test "update_betslip/2 with valid data updates the betslip" do
      betslip = betslip_fixture()

      update_attrs = %{
        odds: 456.7,
        result_type: "some updated result_type",
        status: "some updated status"
      }

      assert {:ok, %Betslip{} = betslip} = Betslips.update_betslip(betslip, update_attrs)
      assert betslip.odds == 456.7
      assert betslip.result_type == "some updated result_type"
      assert betslip.status == "some updated status"
    end

    test "update_betslip/2 with invalid data returns error changeset" do
      betslip = betslip_fixture()
      assert {:error, %Ecto.Changeset{}} = Betslips.update_betslip(betslip, @invalid_attrs)
      assert betslip == Betslips.get_betslip!(betslip.id)
    end

    test "delete_betslip/1 deletes the betslip" do
      betslip = betslip_fixture()
      assert {:ok, %Betslip{}} = Betslips.delete_betslip(betslip)
      assert_raise Ecto.NoResultsError, fn -> Betslips.get_betslip!(betslip.id) end
    end

    test "change_betslip/1 returns a betslip changeset" do
      betslip = betslip_fixture()
      assert %Ecto.Changeset{} = Betslips.change_betslip(betslip)
    end
  end
end

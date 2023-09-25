defmodule BettingSystem.SportsTest do
  use BettingSystem.DataCase

  alias BettingSystem.Sports

  describe "sports" do
    alias BettingSystem.Sports.Sport

    import BettingSystem.SportsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_sports/0 returns all sports" do
      sport = sport_fixture()
      assert Sports.list_sports() == [sport]
    end

    test "get_sport!/1 returns the sport with given id" do
      sport = sport_fixture()
      assert Sports.get_sport!(sport.id) == sport
    end

    test "create_sport/1 with valid data creates a sport" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Sport{} = sport} = Sports.create_sport(valid_attrs)
      assert sport.description == "some description"
      assert sport.name == "some name"
    end

    test "create_sport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sports.create_sport(@invalid_attrs)
    end

    test "update_sport/2 with valid data updates the sport" do
      sport = sport_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Sport{} = sport} = Sports.update_sport(sport, update_attrs)
      assert sport.description == "some updated description"
      assert sport.name == "some updated name"
    end

    test "update_sport/2 with invalid data returns error changeset" do
      sport = sport_fixture()
      assert {:error, %Ecto.Changeset{}} = Sports.update_sport(sport, @invalid_attrs)
      assert sport == Sports.get_sport!(sport.id)
    end

    test "delete_sport/1 deletes the sport" do
      sport = sport_fixture()
      assert {:ok, %Sport{}} = Sports.delete_sport(sport)
      assert_raise Ecto.NoResultsError, fn -> Sports.get_sport!(sport.id) end
    end

    test "change_sport/1 returns a sport changeset" do
      sport = sport_fixture()
      assert %Ecto.Changeset{} = Sports.change_sport(sport)
    end
  end
end

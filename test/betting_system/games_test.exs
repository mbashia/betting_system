defmodule BettingSystem.GamesTest do
  use BettingSystem.DataCase

  alias BettingSystem.Games

  describe "games" do
    alias BettingSystem.Games.Game

    import BettingSystem.GamesFixtures

    @invalid_attrs %{
      date: nil,
      draw: nil,
      location: nil,
      lose: nil,
      result: nil,
      status: nil,
      type: nil,
      win: nil
    }

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{
        date: ~N[2023-09-04 19:13:00],
        draw: 120.5,
        location: "some location",
        lose: 120.5,
        result: "some result",
        status: "some status",
        type: "some type",
        win: 120.5
      }

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.date == ~N[2023-09-04 19:13:00]
      assert game.draw == 120.5
      assert game.location == "some location"
      assert game.lose == 120.5
      assert game.result == "some result"
      assert game.status == "some status"
      assert game.type == "some type"
      assert game.win == 120.5
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()

      update_attrs = %{
        date: ~N[2023-09-05 19:13:00],
        draw: 456.7,
        location: "some updated location",
        lose: 456.7,
        result: "some updated result",
        status: "some updated status",
        type: "some updated type",
        win: 456.7
      }

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.date == ~N[2023-09-05 19:13:00]
      assert game.draw == 456.7
      assert game.location == "some updated location"
      assert game.lose == 456.7
      assert game.result == "some updated result"
      assert game.status == "some updated status"
      assert game.type == "some updated type"
      assert game.win == 456.7
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end

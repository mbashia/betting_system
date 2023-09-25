defmodule BettingSystemWeb.SimulategamesLive.Index do
  use BettingSystemWeb, :live_view
  alias BettingSystem.Users
  alias BettingSystem.Games
  alias BettingSystem.Bet
  alias BettingSystem.Accounts.User
  alias BettingSystem.Accounts
  alias BettingSystem.Repo
  alias BettingSystem.Games
  alias BettingSystem.Betslips
  alias BettingSystem.Accounts.UserNotifier

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"]) |> Repo.preload(:betslips)

    games = Games.list_games()

    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:games, games)
     |> assign(:pending_error, "")}
  end

  def handle_event("simulate", _params, socket) do
    pending_games = Games.list_pending_games()
    pending_error = ""
    IO.inspect(pending_games)

    pending_error =
      if pending_games == [] do
        "no games are pending"
      else
        ""
      end

    Enum.each(pending_games, fn game ->
      random_result = Enum.random(["team1 win", "game_draw", "team2 win"])

      random_updates = %{"status" => "completed", "result" => random_result}
      Games.update_game(game, random_updates)
    end)

    games = Games.list_games()

    {:noreply,
     socket
     |> assign(:games, games)
     |> assign(:pending_error, pending_error)}
  end
end

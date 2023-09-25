defmodule BettingSystemWeb.UserLive.Index do
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
  @impl true
  def mount(_params, session, socket) do
    # :timer.send_interval(20000, self(), :update_games)

    user = Accounts.get_user_by_session_token(session["user_token"]) |> Repo.preload(:betslips)
    users = Users.list_users()
    user_bets = Bet.get_all_bets(user.id) |> Enum.reverse()

    number =
      if length(user_bets) == 1 do
        "bet"
      else
        "bets"
      end

    {:ok,
     socket
     |> assign(:clients, users)
     |> assign(:user, user)
     |> assign(:check_bet_history, 0)
     |> assign(:bets, user_bets)
     |> assign(:number, number)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    IO.write("we are here")
    IO.inspect(id)
    id = String.to_integer(id)
    IO.inspect(id)

    socket
    |> assign(:page_title, "Edit user")
    |> assign(:user_edit, Users.get_user!(id))
  end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New user")
  #   |> assign(:user, %User{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing users")
    |> assign(:sport, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)

    cond do
      user.status == "active" ->
        case Users.update_user(user, %{status: "inactive"}) do
          {:ok, _user} ->
            users = Users.list_users()

            {:noreply,
             socket
             |> put_flash(:info, "User deactivated successfully")
             |> assign(:clients, users)}

          {:error, _changeset} ->
            {:noreply,
             socket
             |> put_flash(:error, "Failed to deactivate user")}
        end

      user.status == "inactive" ->
        case Users.update_user(user, %{status: "active"}) do
          {:ok, _user} ->
            users = Users.list_users()

            {:noreply,
             socket
             |> put_flash(:info, "User activated successfully")
             |> assign(:clients, users)}

          {:error, _changeset} ->
            {:noreply,
             socket
             |> put_flash(:error, "Failed to activate user:")}
        end

      true ->
        socket
        |> put_flash(:error, "Invalid user status")
    end

    # {:ok, _} = Users.delete_user(users)

    # {:noreply, assign(socket, :users, Users.list_users())}
  end

  def handle_event("bet history", params, socket) do
    {:noreply,
     socket
     |> assign(:check_bet_history, 1)}
  end

  def handle_event("close_pop_up", params, socket) do
    {:noreply,
     socket
     |> assign(:check_bet_history, 0)}
  end

  def handle_info(:update_games, socket) do
    user_betslips = Betslips.get_betslip_user_id(socket.assigns.user.id)

    Enum.each(user_betslips, fn betslip ->
      game_id = betslip.game_id
      game = Games.get_game!(game_id)

      case game.status do
        "completed" ->
          if game.result == betslip.result_type do
            Betslips.update_betslip(betslip, %{"end_result" => "won"})
          else
            Betslips.update_betslip(betslip, %{"end_result" => "lost"})
          end

        "pending" ->
          _pending = "pending"
      end
    end)

    # this code from here  i cant rembember i was in the zone and it might not be working check later
    user_bets = Bet.get_all_bets(socket.assigns.user.id)

    Enum.each(user_bets, fn bet ->
      game_ids = Map.values(bet.bet_items)

      bet_status =
        Enum.reduce(game_ids, :win, fn x, acc ->
          IO.write("Checking betslip for game ID #{x}")
          betslip = Betslips.getting_betslip(socket.assigns.user.id, x)
          IO.inspect(betslip)
          IO.write("above inspected betslip")

          case betslip.end_result do
            "won" -> acc
            "lost" -> :lost
            _ -> false
          end
        end)

      case bet_status do
        :win ->
          Bet.update_bets(bet, %{"end_result" => "win", "status" => "closed"})
          UserNotifier.bet_win_results_email(bet, socket.assigns.user)

        :lost ->
          Bet.update_bets(bet, %{"end_result" => "lost", "status" => "closed"})
          UserNotifier.bet_loss_results_email(bet, socket.assigns.user)

        false ->
          _false = "false"
      end
    end)

    {:noreply, socket}
  end
end

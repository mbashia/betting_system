defmodule BettingSystemWeb.UserLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Betslips
  alias BettingSystem.Accounts
  alias BettingSystem.Users
  alias BettingSystem.Bet

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:check_bet_history, 0)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user_bets = Bet.get_all_bets(id) |> Enum.reverse()

    number =
      if length(user_bets) == 1 do
        "bet"
      else
        "bets"
      end

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:betslips, Betslips.get_betslip_user_id(id))
     |> assign(:system_user, Users.get_user!(id))
     |> assign(:bets, user_bets)
     |> assign(:number, number)}
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

  defp page_title(:show), do: "Show user"
  defp page_title(:edit), do: "Edit Sport"
end

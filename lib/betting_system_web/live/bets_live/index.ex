defmodule BettingSystemWeb.BetsLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Bet
  alias BettingSystem.Bet.Bets
  alias BettingSystem.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:bets_collection, list_bets())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bets")
    |> assign(:bets, Bet.get_bets!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bets")
    |> assign(:bets, %Bets{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bets")
    |> assign(:bets, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bets = Bet.get_bets!(id)
    {:ok, _} = Bet.delete_bets(bets)

    {:noreply, assign(socket, :bets_collection, list_bets())}
  end

  defp list_bets do
    Bet.list_bets()
  end
end

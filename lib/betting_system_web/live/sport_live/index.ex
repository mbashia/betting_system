defmodule BettingSystemWeb.SportLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Sports
  alias BettingSystem.Sports.Sport
  alias BettingSystem.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:sports, list_sports())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sport")
    |> assign(:sport, Sports.get_sport!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sport")
    |> assign(:sport, %Sport{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sports")
    |> assign(:sport, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sport = Sports.get_sport!(id)
    {:ok, _} = Sports.delete_sport(sport)

    {:noreply, assign(socket, :sports, list_sports())}
  end

  defp list_sports do
    Sports.list_sports()
  end
end

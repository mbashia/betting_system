defmodule BettingSystemWeb.BetsLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Bet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bets, Bet.get_bets!(id))}
  end

  defp page_title(:show), do: "Show Bets"
  defp page_title(:edit), do: "Edit Bets"
end

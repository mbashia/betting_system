defmodule BettingSystemWeb.SportLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Sports

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sport, Sports.get_sport!(id))}
  end

  defp page_title(:show), do: "Show Sport"
  defp page_title(:edit), do: "Edit Sport"
end

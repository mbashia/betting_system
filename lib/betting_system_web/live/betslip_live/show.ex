defmodule BettingSystemWeb.BetslipLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Betslips

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:betslip, Betslips.get_betslip!(id))}
  end

  defp page_title(:show), do: "Show Betslip"
  defp page_title(:edit), do: "Edit Betslip"
end

defmodule BettingSystemWeb.BetslipLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Betslips
  alias BettingSystem.Betslips.Betslip

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :betslips, list_betslips())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Betslip")
    |> assign(:betslip, Betslips.get_betslip!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Betslip")
    |> assign(:betslip, %Betslip{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Betslips")
    |> assign(:betslip, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    betslip = Betslips.get_betslip!(id)
    {:ok, _} = Betslips.delete_betslip(betslip)

    {:noreply, assign(socket, :betslips, list_betslips())}
  end

  defp list_betslips do
    Betslips.list_betslips()
  end
end

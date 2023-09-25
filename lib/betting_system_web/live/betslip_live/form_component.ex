defmodule BettingSystemWeb.BetslipLive.FormComponent do
  use BettingSystemWeb, :live_component

  alias BettingSystem.Betslips

  @impl true
  def update(%{betslip: betslip} = assigns, socket) do
    changeset = Betslips.change_betslip(betslip)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"betslip" => betslip_params}, socket) do
    changeset =
      socket.assigns.betslip
      |> Betslips.change_betslip(betslip_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"betslip" => betslip_params}, socket) do
    save_betslip(socket, socket.assigns.action, betslip_params)
  end

  defp save_betslip(socket, :edit, betslip_params) do
    case Betslips.update_betslip(socket.assigns.betslip, betslip_params) do
      {:ok, _betslip} ->
        {:noreply,
         socket
         |> put_flash(:info, "Betslip updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_betslip(socket, :new, betslip_params) do
    case Betslips.create_betslip(betslip_params) do
      {:ok, _betslip} ->
        {:noreply,
         socket
         |> put_flash(:info, "Betslip created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

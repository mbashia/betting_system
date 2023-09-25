defmodule BettingSystemWeb.BetsLive.FormComponent do
  use BettingSystemWeb, :live_component

  alias BettingSystem.Bet

  @impl true
  def update(%{bets: bets} = assigns, socket) do
    changeset = Bet.change_bets(bets)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bets" => bets_params}, socket) do
    changeset =
      socket.assigns.bets
      |> Bet.change_bets(bets_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bets" => bets_params}, socket) do
    save_bets(socket, socket.assigns.action, bets_params)
  end

  defp save_bets(socket, :edit, bets_params) do
    case Bet.update_bets(socket.assigns.bets, bets_params) do
      {:ok, _bets} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bets updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bets(socket, :new, bets_params) do
    IO.inspect(bets_params)

    new_bet_params =
      bets_params
      |> Map.put("user_id", socket.assigns.user.id)

    IO.inspect(new_bet_params)

    case Bet.create_bets(new_bet_params) do
      {:ok, _bets} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bets created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

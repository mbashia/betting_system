defmodule BettingSystemWeb.UserLive.FormComponent do
  use BettingSystemWeb, :live_component
  # alias  BettingSystem.Accounts.User
  alias BettingSystem.Users

  def update(%{user: user} = assigns, socket) do
    changeset = Users.change_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Users.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    phone_number = user_params["phone_number"] |> String.to_integer()
    IO.inspect(phone_number)

    user_params = Map.put(user_params, "phone_number", phone_number)
    IO.inspect(user_params)
    save_user(socket, socket.assigns.action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    IO.inspect(socket.assigns.user)

    case Users.update_user(socket.assigns.user, user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "user updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.write("error")
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end

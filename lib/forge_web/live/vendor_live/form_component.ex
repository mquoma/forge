defmodule ForgeWeb.VendorLive.FormComponent do
  use ForgeWeb, :live_component

  alias Forge.Accounts

  @impl true
  def update(%{vendor: vendor} = assigns, socket) do
    changeset = Accounts.change_vendor(vendor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"vendor" => vendor_params}, socket) do
    changeset =
      socket.assigns.vendor
      |> Accounts.change_vendor(vendor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"vendor" => vendor_params}, socket) do
    save_vendor(socket, socket.assigns.action, vendor_params)
  end

  defp save_vendor(socket, :edit, vendor_params) do
    case Accounts.update_vendor(socket.assigns.vendor, vendor_params) do
      {:ok, _vendor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Vendor updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_vendor(socket, :new, vendor_params) do
    case Accounts.create_vendor(vendor_params) do
      {:ok, _vendor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Vendor created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule ForgeWeb.VendorLive.Index do
  use ForgeWeb, :live_view

  alias Forge.Accounts
  alias Forge.Accounts.Vendor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :vendors, list_vendors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vendor")
    |> assign(:vendor, Accounts.get_vendor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vendor")
    |> assign(:vendor, %Vendor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vendors")
    |> assign(:vendor, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vendor = Accounts.get_vendor!(id)
    {:ok, _} = Accounts.delete_vendor(vendor)

    {:noreply, assign(socket, :vendors, list_vendors())}
  end

  defp list_vendors do
    Accounts.list_vendors()
  end
end

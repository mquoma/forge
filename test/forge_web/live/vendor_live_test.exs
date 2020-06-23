defmodule ForgeWeb.VendorLiveTest do
  use ForgeWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Forge.Accounts

  @create_attrs %{email: "some email", name: "some name"}
  @update_attrs %{email: "some updated email", name: "some updated name"}
  @invalid_attrs %{email: nil, name: nil}

  defp fixture(:vendor) do
    {:ok, vendor} = Accounts.create_vendor(@create_attrs)
    vendor
  end

  defp create_vendor(_) do
    vendor = fixture(:vendor)
    %{vendor: vendor}
  end

  describe "Index" do
    setup [:create_vendor]

    test "lists all vendors", %{conn: conn, vendor: vendor} do
      {:ok, _index_live, html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert html =~ "Listing Vendors"
      assert html =~ vendor.email
    end

    test "saves new vendor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert index_live |> element("a", "New Vendor") |> render_click() =~
               "New Vendor"

      assert_patch(index_live, Routes.vendor_index_path(conn, :new))

      assert index_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#vendor-form", vendor: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vendor_index_path(conn, :index))

      assert html =~ "Vendor created successfully"
      assert html =~ "some email"
    end

    test "updates vendor in listing", %{conn: conn, vendor: vendor} do
      {:ok, index_live, _html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert index_live |> element("#vendor-#{vendor.id} a", "Edit") |> render_click() =~
               "Edit Vendor"

      assert_patch(index_live, Routes.vendor_index_path(conn, :edit, vendor))

      assert index_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#vendor-form", vendor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vendor_index_path(conn, :index))

      assert html =~ "Vendor updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes vendor in listing", %{conn: conn, vendor: vendor} do
      {:ok, index_live, _html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert index_live |> element("#vendor-#{vendor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vendor-#{vendor.id}")
    end
  end

  describe "Show" do
    setup [:create_vendor]

    test "displays vendor", %{conn: conn, vendor: vendor} do
      {:ok, _show_live, html} = live(conn, Routes.vendor_show_path(conn, :show, vendor))

      assert html =~ "Show Vendor"
      assert html =~ vendor.email
    end

    test "updates vendor within modal", %{conn: conn, vendor: vendor} do
      {:ok, show_live, _html} = live(conn, Routes.vendor_show_path(conn, :show, vendor))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vendor"

      assert_patch(show_live, Routes.vendor_show_path(conn, :edit, vendor))

      assert show_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#vendor-form", vendor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vendor_show_path(conn, :show, vendor))

      assert html =~ "Vendor updated successfully"
      assert html =~ "some updated email"
    end
  end
end

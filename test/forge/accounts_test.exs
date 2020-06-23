defmodule Forge.AccountsTest do
  use Forge.DataCase

  alias Forge.Accounts

  describe "customers" do
    alias Forge.Accounts.Customer

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Accounts.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Accounts.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Accounts.create_customer(@valid_attrs)
      assert customer.email == "some email"
      assert customer.name == "some name"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Accounts.update_customer(customer, @update_attrs)
      assert customer.email == "some updated email"
      assert customer.name == "some updated name"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_customer(customer, @invalid_attrs)
      assert customer == Accounts.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Accounts.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_customer(customer)
    end
  end

  describe "vendors" do
    alias Forge.Accounts.Vendor

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def vendor_fixture(attrs \\ %{}) do
      {:ok, vendor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_vendor()

      vendor
    end

    test "list_vendors/0 returns all vendors" do
      vendor = vendor_fixture()
      assert Accounts.list_vendors() == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given id" do
      vendor = vendor_fixture()
      assert Accounts.get_vendor!(vendor.id) == vendor
    end

    test "create_vendor/1 with valid data creates a vendor" do
      assert {:ok, %Vendor{} = vendor} = Accounts.create_vendor(@valid_attrs)
      assert vendor.email == "some email"
      assert vendor.name == "some name"
    end

    test "create_vendor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_vendor(@invalid_attrs)
    end

    test "update_vendor/2 with valid data updates the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{} = vendor} = Accounts.update_vendor(vendor, @update_attrs)
      assert vendor.email == "some updated email"
      assert vendor.name == "some updated name"
    end

    test "update_vendor/2 with invalid data returns error changeset" do
      vendor = vendor_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_vendor(vendor, @invalid_attrs)
      assert vendor == Accounts.get_vendor!(vendor.id)
    end

    test "delete_vendor/1 deletes the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{}} = Accounts.delete_vendor(vendor)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_vendor!(vendor.id) end
    end

    test "change_vendor/1 returns a vendor changeset" do
      vendor = vendor_fixture()
      assert %Ecto.Changeset{} = Accounts.change_vendor(vendor)
    end
  end
end

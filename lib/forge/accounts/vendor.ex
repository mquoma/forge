defmodule Forge.Accounts.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vendors" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(vendor, attrs) do
    vendor
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end

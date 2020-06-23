defmodule Forge.Repo.Migrations.CreateVendors do
  use Ecto.Migration

  def change do
    create table(:vendors) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end

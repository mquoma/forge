defmodule Forge.Repo do
  use Ecto.Repo,
    otp_app: :forge,
    adapter: Ecto.Adapters.Postgres
end

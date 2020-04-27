defmodule Epas.Repo do
  use Ecto.Repo,
    otp_app: :epas,
    adapter: Ecto.Adapters.Postgres
end

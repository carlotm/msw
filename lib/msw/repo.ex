defmodule Msw.Repo do
  use Ecto.Repo,
    otp_app: :msw,
    adapter: Ecto.Adapters.Postgres
end

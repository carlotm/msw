defmodule Msw.Seasons do
  @moduledoc false

  import Ecto.Query
  alias Msw.Schemas.Season
  alias Msw.Repo

  def all do
    from(s in Season, order_by: [s.number]) |> Repo.all()
  end
end

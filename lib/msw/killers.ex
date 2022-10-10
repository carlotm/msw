defmodule Msw.Killers do
  @moduledoc false

  import Ecto.Query
  alias Msw.Schemas.Killer
  alias Msw.Repo

  def random(n) do
    from(k in Killer) |> Repo.all() |> Enum.take_random(n)
  end

  def killer_of(episode) do
    from(k in Killer, where: k.episode_id == ^episode.id) |> Repo.one()
  end

  def by_id(id) do
    Repo.get(Killer, id)
  end
end

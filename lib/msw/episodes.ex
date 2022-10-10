defmodule Msw.Episodes do
  @moduledoc false

  import Ecto.Query
  alias Msw.Schemas.{Episode, Season, Killer}
  alias Msw.Repo

  def all_episodes do
    from(e in Episode, order_by: [e.season_id, e.number], preload: :season)
  end

  def all do
    all_episodes() |> Repo.all()
  end

  def by_season(season_n) do
    case from(s in Season, where: s.number == ^season_n) |> Repo.one() do
      nil ->
        []

      s ->
        from(e in all_episodes(), where: e.season_id == ^s.id)
        |> Repo.all()
    end
  end

  def killer_of(episode_id) do
    from(k in Killer,
      join: e in Episode,
      on: k.episode_id == e.id,
      where: k.episode_id == ^episode_id
    )
    |> Repo.one()
  end
end

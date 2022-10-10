defmodule Msw.Seeds do
  @root_dir File.cwd!()
  @data_dir Path.join(@root_dir, "priv/data")
  @seeds [
    {"seasons", "id, number, external_id, inserted_at, updated_at"},
    {"episodes",
     "id, number, external_id, title, plot, poster, season_id, inserted_at, updated_at"},
    {"killers", "id, name, episode_id, picture, picture64, inserted_at, updated_at"}
  ]

  defp load({table, columns}) do
    file = Path.join(@data_dir, "#{table}.csv")
    Msw.Repo.query!("COPY #{table} (#{columns}) FROM '#{file}' WITH (FORMAT csv, HEADER True)")
  end

  def run() do
    Enum.each(@seeds, &load/1)
  end
end

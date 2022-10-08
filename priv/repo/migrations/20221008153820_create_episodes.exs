defmodule Msw.Repo.Migrations.CreateEpisodes do
  use Ecto.Migration

  def change do
    create table(:episodes) do
      add(:number, :integer)
      add(:external_id, :integer)
      add(:title, :string)
      add(:plot, :text)
      add(:poster, :string)
      add(:season_id, references(:seasons, on_delete: :delete_all))

      timestamps()
    end
  end
end

defmodule Msw.Repo.Migrations.CreateSeasons do
  use Ecto.Migration

  def change do
    create table(:seasons) do
      add :number, :integer
      add :external_id, :integer

      timestamps()
    end
  end
end

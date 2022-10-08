defmodule Msw.Repo.Migrations.CreateKiller do
  use Ecto.Migration

  def change do
    create table(:killers) do
      add(:name, :string)
      add(:picture, :string)
      add(:picture64, :text)
      add(:episode_id, references(:episodes, on_delete: :delete_all))

      timestamps()
    end
  end
end

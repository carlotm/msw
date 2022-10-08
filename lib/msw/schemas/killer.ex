defmodule Msw.Schemas.Killer do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias MSW.Schemas.Episode

  @required_fields [:name, :picture, :picture64]

  schema "episodes" do
    field :name, :string
    field :picture, :string
    field :picture64, :string

    belongs_to :episode, Episode

    timestamps()
  end

  def changeset(season, attrs) do
    season
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:episode)
  end
end

defmodule Msw.Schemas.Season do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:external_id, :number]

  schema "seasons" do
    field :external_id, :integer
    field :number, :integer

    timestamps()
  end

  def changeset(season, attrs) do
    season
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end

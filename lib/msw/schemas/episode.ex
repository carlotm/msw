defmodule Msw.Schemas.Episode do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias MSW.Schemas.Season

  @required_fields [:external_id, :number, :title, :plot, :poster]

  schema "episodes" do
    field :external_id, :integer
    field :number, :integer
    field :plot, :string
    field :poster, :string
    field :title, :string

    belongs_to :season, Season

    timestamps()
  end

  def changeset(season, attrs) do
    season
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:season)
  end
end

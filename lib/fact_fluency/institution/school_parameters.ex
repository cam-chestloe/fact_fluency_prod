defmodule FactFluency.Institution.SchoolParameters do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Institution.{SchoolParameters, School}


  schema "school_parameters" do
    field :teachers_can_edit_test_parameters, :boolean, default: false
    field :teachers_can_edit_warmup_parameters, :boolean, default: false

    belongs_to :school, School

    timestamps()
  end

  @doc false
  def changeset(%SchoolParameters{} = school_parameters, attrs) do
    school_parameters
    |> cast(attrs, [:teachers_can_edit_test_parameters, :teachers_can_edit_warmup_parameters])
    |> validate_required([:teachers_can_edit_test_parameters, :teachers_can_edit_warmup_parameters])
  end
end

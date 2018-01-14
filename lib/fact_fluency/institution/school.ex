defmodule FactFluency.Institution.School do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Institution.School


  schema "schools" do
    field :name, :string

    has_many :teachers, FactFluency.Teachers.Teacher
    has_one :school_parameters, FactFluency.Institution.SchoolParameters
    has_one :test_parameters, FactFluency.Testing.TestParameters

    timestamps()
  end

  @doc false
  def changeset(%School{} = school, attrs) do
    school
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

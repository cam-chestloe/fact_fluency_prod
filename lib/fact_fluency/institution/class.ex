defmodule FactFluency.Institution.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Institution.Class


  schema "classes" do
    field :grade, :integer
    field :name, :string

    has_many :students, FactFluency.Students.Student
    has_one :test_parameters, FactFluency.Testing.TestParameters

    belongs_to :teacher, FactFluency.Teachers.Teacher

    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:name, :grade, :teacher_id])
    |> validate_required([:name, :grade, :teacher_id])
  end
end

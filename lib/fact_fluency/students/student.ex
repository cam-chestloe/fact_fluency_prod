defmodule FactFluency.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Students.Student


  schema "students" do
    field :duplicate_id, :string
    field :last_initial, :string
    field :timestamps, :string

    has_one :test_parameters, FactFluency.Testing.TestParameters
    many_to_many :parents, FactFluency.Parents.Parent, join_through: "parents_students", on_delete: :delete_all
    has_many :tests, FactFluency.Testing.Test

    belongs_to :class, FactFluency.Institution.Class
    belongs_to :user, FactFluency.Accounts.User 

    timestamps()
  end

  @doc false
  def changeset(%Student{} = student, attrs) do
    student
    |> cast(attrs, [:last_initial, :duplicate_id, :class_id])
    |> cast_assoc(:user, [])
    |> validate_required([:last_initial, :user])
  end
end

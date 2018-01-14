defmodule FactFluency.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Students.Student


  schema "students" do
    field :duplicate_id, :string
    field :first_name, :string
    field :last_initial, :string
    field :timestamps, :string

    has_one :test_parameters, FactFluency.Testing.TestParameters
    has_many :parents, FactFluency.Parents.Parent
    has_many :tests, FactFluency.Testing.Test

    belongs_to :class, FactFluency.Institution.Class
    belongs_to :user, FactFluency.Accounts.User 

    timestamps()
  end

  @doc false
  def changeset(%Student{} = student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_initial, :duplicate_id, :class_id, :user_id])
    |> validate_required([:first_name, :last_initial, :duplicate_id, :class_id, :user_id])
  end
end

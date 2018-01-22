defmodule FactFluency.Teachers.Teacher do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Teachers.Teacher


  schema "teachers" do
    field :last_name, :string
    field :timestamps, :string

    belongs_to :school, FactFluency.Institution.School
    belongs_to :user, FactFluency.Accounts.User

    has_many :classes, FactFluency.Institution.Class

    has_one :test_parameters, FactFluency.Testing.TestParameters

    timestamps()
  end

  @doc false
  def changeset(%Teacher{} = teacher, attrs) do
    teacher
    |> cast(attrs, [:last_name, :user_id, :school_id])
    |> cast_assoc(:user, [])
    |> validate_required([:last_name, :user])
  end
end

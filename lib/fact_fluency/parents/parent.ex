defmodule FactFluency.Parents.Parent do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Parents.Parent


  schema "parents" do
    field :email, :string
    field :first_name, :string

    belongs_to :student, FactFluency.Students.Student
    belongs_to :user, FactFluency.Accounts.User 

    timestamps()
  end

  @doc false
  def changeset(%Parent{} = parent, attrs) do
    parent
    |> cast(attrs, [:first_name, :email])
    |> validate_required([:first_name, :email])
  end
end

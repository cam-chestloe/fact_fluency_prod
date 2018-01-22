defmodule FactFluency.Parents.Parent do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Parents.Parent


  schema "parents" do

    many_to_many :student, FactFluency.Students.Student, join_through: "parents_students", on_delete: :delete_all
    belongs_to :user, FactFluency.Accounts.User 

    timestamps()
  end

  @doc false
  def changeset(%Parent{} = parent, attrs) do
    parent
    |> Ecto.Changeset.change(attrs)
    |> cast_assoc(:user, [])
    |> validate_required([:user])
  end
end

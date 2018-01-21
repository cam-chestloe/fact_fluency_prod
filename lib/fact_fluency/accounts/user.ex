defmodule FactFluency.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Accounts.{User, Credential}


  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> cast_assoc(:credential, [])
    |> validate_required([:name, :username, :credential])
    |> unique_constraint(:username)
  end
end

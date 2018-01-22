defmodule FactFluency.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Accounts.{User, Credential}


  schema "users" do
    field :first_name, :string
    field :username, :string
    field :admin, :boolean, defaults: false
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :username, :admin])
    |> cast_assoc(:credential, [])
    |> validate_required([:first_name, :username, :credential])
    |> unique_constraint(:username)
  end
end

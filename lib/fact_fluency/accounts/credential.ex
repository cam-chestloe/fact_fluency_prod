defmodule FactFluency.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Accounts.{Credential, User}


  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(pass))
      
      _ ->
        changeset
    end
  end
end

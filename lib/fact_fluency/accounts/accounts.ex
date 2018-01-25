defmodule FactFluency.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false

  alias FactFluency.Repo
  alias FactFluency.Accounts.{User, Credential}
  alias FactFluency.Teachers.Teacher
  alias FactFluency.Students.Student
  alias FactFluency.Parents.Parent

  @doc """
  Returns the list of users.

  ## Examples
      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
    |> Repo.preload(:credential)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User 
    |> Repo.get!(id)
    |> Repo.preload(:credential)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
    |> Ecto.Changeset.cast_assoc(:credential)
  end


  @doc """
  Returns the list of credentials.

  ## Examples

      iex> list_credentials()
      [%Credential{}, ...]

  """
  def list_credentials do
    Repo.all(Credential)
  end

  @doc """
  Gets a single credential.

  Raises `Ecto.NoResultsError` if the Credential does not exist.

  ## Examples

      iex> get_credential!(123)
      %Credential{}

      iex> get_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_credential!(id), do: Repo.get!(Credential, id)

  @doc """
  Creates a credential.

  ## Examples

      iex> create_credential(%{field: value})
      {:ok, %Credential{}}

      iex> create_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a credential.

  ## Examples

      iex> update_credential(credential, %{field: new_value})
      {:ok, %Credential{}}

      iex> update_credential(credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Credential.

  ## Examples

      iex> delete_credential(credential)
      {:ok, %Credential{}}

      iex> delete_credential(credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking credential changes.

  ## Examples

      iex> change_credential(credential)
      %Ecto.Changeset{source: %Credential{}}

  """
  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end

  @doc """
  Authenticates a user using ``email`` and ``password`` for the specified ``user_type``.

  ## Examples
        iex> authenticate_by_email_password(email, password, "teacher")
        {:ok, %Teacher{}}

        iex> authenticate_by_email_password(email, bad_password, bad_type)
        {:error, :unauthorized}
  """
  @spec authenticate_by_email_password(String.t(), String.t(), String.t()) :: {:ok, %User{}} | {:error, :unauthorized}
  def authenticate_by_email_password(email, password, user_type) do
    type = 
        case user_type do
            "Teacher" -> from t in Teacher, inner_join: u in assoc(t, :user)
            "Student" -> from s in Student, inner_join: u in assoc(s, :user)
            "Parent" -> from p in Parent, inner_join: u in assoc(p, :user)
            "Admin" -> from u in User, where: u.admin == true
        end

    query =
        from [t, u] in type,
        inner_join: c in assoc(u, :credential),
        where: c.email == ^email,
        preload: [user: {u, :credential}]

    case Repo.one(query) do
        %{} = user -> 
            IO.inspect(user)
            if Comeonin.Bcrypt.checkpw(password, user.user.credential.password_hash) do
                {:ok, user}
            else
                {:error, :unauthorized}
            end

        _ -> 
            {:error, :unauthorized}
    end
  end
end
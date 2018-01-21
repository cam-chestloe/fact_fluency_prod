defmodule FactFluency.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias FactFluency.Repo

  alias FactFluency.Accounts.{User, Credential}

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
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.registration_changeset/2)
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
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.registration_changeset/2)
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
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.registration_changeset/2)
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
    |> Credential.registration_changeset(attrs)
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
    |> Credential.registration_changeset(attrs)
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
    Credential.registration_changeset(credential, %{})
  end

  @doc """
  Authenticates a user using ``email`` and ``password``.

  ## Examples
        iex> authenticate_by_email_password(email, password)
        {:ok, %User{}}

        iex> authenticate_by_email_password(email, password)
        {:error, :unauthorized}
  """
  @spec authenticate_by_email_password(String.t(), String.t()) :: {:ok, %User{}} | {:error, :unauthorized}
  def authenticate_by_email_password(email, password) do
    query =
        from u in User,
        inner_join: c in assoc(u, :credential),
        where: c.email == ^email,
        preload: :credential

    case Repo.one(query) do
        %User{} = user -> 
        if Comeonin.Bcrypt.checkpw(password, user.credential.password_hash) do
            {:ok, user}
        else
            {:error, :unauthorized}
        end

        {:error, message} -> 
        IO.puts(message)
        {:error, :unauthorized}
    end
  end

  @doc """
  Authenticates a user using ``email``, ``password``, and ``user type``

  ## Examples
        iex> authentication_by_email_password_type(email, password, type)
        {:ok, %User{}}

        iex> authentication_by_email_password_type(email, bad_pass, wrong_type)
        {:error, :unauthorized}
  """
  def authenticate_by_email_password(email, password, type) do
    case authenticate_by_email_password(email, password) do
        {:ok, user} ->
           query =
                case type do
                    :student -> 
                        from u in User, 
                        inner_join: s in FactFluency.Students.Student, 
                        on: s.user_id == u.id
                    :teacher ->
                        from u in User,
                        inner_join: t in FactFluency.Teachers.Teacher,
                        on: t.user_id == u.id
                    :parent ->
                        from u in User,
                        inner_join: p in FactFluency.Parents.Parent,
                        on: p.user_id == u.id
                end

            case Repo.one(query) do
                {:ok, student} -> 
            end
                
    end
  end
end
defmodule FactFluency.Institution do
  @moduledoc """
  The Institution context.
  """

  import Ecto.Query, warn: false
  alias FactFluency.Repo

  alias FactFluency.Institution.School

  @doc """
  Returns the list of schools.

  ## Examples

      iex> list_schools()
      [%School{}, ...]

  """
  def list_schools do
    Repo.all(School)
  end

  @doc """
  Gets a single school.

  Raises `Ecto.NoResultsError` if the School does not exist.

  ## Examples

      iex> get_school!(123)
      %School{}

      iex> get_school!(456)
      ** (Ecto.NoResultsError)

  """
  def get_school!(id), do: Repo.get!(School, id)

  @doc """
  Creates a school.

  ## Examples

      iex> create_school(%{field: value})
      {:ok, %School{}}

      iex> create_school(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_school(attrs \\ %{}) do
    %School{}
    |> School.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a school.

  ## Examples

      iex> update_school(school, %{field: new_value})
      {:ok, %School{}}

      iex> update_school(school, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_school(%School{} = school, attrs) do
    school
    |> School.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a School.

  ## Examples

      iex> delete_school(school)
      {:ok, %School{}}

      iex> delete_school(school)
      {:error, %Ecto.Changeset{}}

  """
  def delete_school(%School{} = school) do
    Repo.delete(school)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking school changes.

  ## Examples

      iex> change_school(school)
      %Ecto.Changeset{source: %School{}}

  """
  def change_school(%School{} = school) do
    School.changeset(school, %{})
  end

  alias FactFluency.Institution.Class

  @doc """
  Returns the list of classes.

  ## Examples

      iex> list_classes()
      [%Class{}, ...]

  """
  def list_classes do
    Repo.all(Class)
  end

  @doc """
  Gets a single class.

  Raises `Ecto.NoResultsError` if the Class does not exist.

  ## Examples

      iex> get_class!(123)
      %Class{}

      iex> get_class!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class!(id), do: Repo.get!(Class, id)

  @doc """
  Creates a class.

  ## Examples

      iex> create_class(%{field: value})
      {:ok, %Class{}}

      iex> create_class(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_class(attrs \\ %{}) do
    %Class{}
    |> Class.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class.

  ## Examples

      iex> update_class(class, %{field: new_value})
      {:ok, %Class{}}

      iex> update_class(class, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Class.

  ## Examples

      iex> delete_class(class)
      {:ok, %Class{}}

      iex> delete_class(class)
      {:error, %Ecto.Changeset{}}

  """
  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking class changes.

  ## Examples

      iex> change_class(class)
      %Ecto.Changeset{source: %Class{}}

  """
  def change_class(%Class{} = class) do
    Class.changeset(class, %{})
  end

  alias FactFluency.Institution.SchoolParameters

  @doc """
  Returns the list of school_parameters.

  ## Examples

      iex> list_school_parameters()
      [%SchoolParameters{}, ...]

  """
  def list_school_parameters do
    Repo.all(SchoolParameters)
  end

  @doc """
  Gets a single school_parameters.

  Raises `Ecto.NoResultsError` if the School parameters does not exist.

  ## Examples

      iex> get_school_parameters!(123)
      %SchoolParameters{}

      iex> get_school_parameters!(456)
      ** (Ecto.NoResultsError)

  """
  def get_school_parameters!(id), do: Repo.get!(SchoolParameters, id)

  @doc """
  Creates a school_parameters.

  ## Examples

      iex> create_school_parameters(%{field: value})
      {:ok, %SchoolParameters{}}

      iex> create_school_parameters(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_school_parameters(attrs \\ %{}) do
    %SchoolParameters{}
    |> SchoolParameters.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a school_parameters.

  ## Examples

      iex> update_school_parameters(school_parameters, %{field: new_value})
      {:ok, %SchoolParameters{}}

      iex> update_school_parameters(school_parameters, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_school_parameters(%SchoolParameters{} = school_parameters, attrs) do
    school_parameters
    |> SchoolParameters.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SchoolParameters.

  ## Examples

      iex> delete_school_parameters(school_parameters)
      {:ok, %SchoolParameters{}}

      iex> delete_school_parameters(school_parameters)
      {:error, %Ecto.Changeset{}}

  """
  def delete_school_parameters(%SchoolParameters{} = school_parameters) do
    Repo.delete(school_parameters)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking school_parameters changes.

  ## Examples

      iex> change_school_parameters(school_parameters)
      %Ecto.Changeset{source: %SchoolParameters{}}

  """
  def change_school_parameters(%SchoolParameters{} = school_parameters) do
    SchoolParameters.changeset(school_parameters, %{})
  end
end

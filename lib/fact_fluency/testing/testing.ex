defmodule FactFluency.Testing do
  @moduledoc """
  The Testing context.
  """

  import Ecto.Query, warn: false
  alias FactFluency.Repo

  alias FactFluency.Testing.{TestParameters, Test, Question }

  @doc """
  Returns the list of test_parameters.

  ## Examples

      iex> list_test_parameters()
      [%TestParameters{}, ...]

  """
  def list_test_parameters do
    Repo.all(TestParameters)
  end

  @doc """
  Gets a single test_parameters.

  Raises `Ecto.NoResultsError` if the Test parameters does not exist.

  ## Examples

      iex> get_test_parameters!(123)
      %TestParameters{}

      iex> get_test_parameters!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test_parameters!(id), do: Repo.get!(TestParameters, id)

  @doc """
  Creates a test_parameters.

  ## Examples

      iex> create_test_parameters(%{field: value})
      {:ok, %TestParameters{}}

      iex> create_test_parameters(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test_parameters(attrs \\ %{}) do
    %TestParameters{}
    |> TestParameters.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test_parameters.

  ## Examples

      iex> update_test_parameters(test_parameters, %{field: new_value})
      {:ok, %TestParameters{}}

      iex> update_test_parameters(test_parameters, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test_parameters(%TestParameters{} = test_parameters, attrs) do
    test_parameters
    |> TestParameters.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TestParameters.

  ## Examples

      iex> delete_test_parameters(test_parameters)
      {:ok, %TestParameters{}}

      iex> delete_test_parameters(test_parameters)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test_parameters(%TestParameters{} = test_parameters) do
    Repo.delete(test_parameters)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test_parameters changes.

  ## Examples

      iex> change_test_parameters(test_parameters)
      %Ecto.Changeset{source: %TestParameters{}}

  """
  def change_test_parameters(%TestParameters{} = test_parameters) do
    TestParameters.changeset(test_parameters, %{})
  end

  alias FactFluency.Testing.Test

  @doc """
  Returns the list of tests.

  ## Examples

      iex> list_tests()
      [%Test{}, ...]

  """
  def list_tests do
    Repo.all(Test)
  end

  @doc """
  Gets a single test.

  Raises `Ecto.NoResultsError` if the Test does not exist.

  ## Examples

      iex> get_test!(123)
      %Test{}

      iex> get_test!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test!(id), do: Repo.get!(Test, id)

  @doc """
  Creates a test.

  ## Examples

      iex> create_test(%{field: value})
      {:ok, %Test{}}

      iex> create_test(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test(%{"test_type" => test_type, "number" => number, "operator" => operator, "student_id" => student_id})  do
    {:ok, test} = Test.new_test(test_type, %{operator: operator, number: String.to_integer(number)}, String.to_integer(student_id))
    %{test | start_time: DateTime.utc_now()}
    Repo.insert(test)
  end

  def update_test(%Test{} = test, %{questions: questions, end_time: end_time}) do
    # use ecto transaction  
    test
      |> Ecto.Changeset.put_embed(:questions, questions)
      |> Ecto.Changeset.put_change(:end_time, end_time)
      |> Repo.update()
  end

  @doc """
  Updates a test.

  ## Examples

      iex> update_test(test, %{field: new_value})
      {:ok, %Test{}}

      iex> update_test(test, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test(%Test{} = test, attrs) do
    test
    |> Test.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Test.

  ## Examples

      iex> delete_test(test)
      {:ok, %Test{}}

      iex> delete_test(test)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test(%Test{} = test) do
    Repo.delete(test)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test changes.

  ## Examples

      iex> change_test(test)
      %Ecto.Changeset{source: %Test{}}

  """
  def change_test(%Test{} = test) do
    Test.changeset(test, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_questions(question)
      %Ecto.Changeset{source: %Question{}
  """
  def change_question(%Question{} = question) do
      Question.changeset(question, %{})
  end
end

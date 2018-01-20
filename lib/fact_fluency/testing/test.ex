defmodule FactFluency.Testing.Test do
  use Ecto.Schema
  import Ecto.Changeset
  alias FactFluency.Testing.{Test, TestParameters}
  alias FactFluency.Testing.ElementaryArithmetic, as: Arithmetic


  schema "tests" do
    field :end_time, :naive_datetime
    field :review_start_time, :naive_datetime
    field :start_time, :naive_datetime
    field :timestamps, :string

    embeds_many :questions, FactFluency.Testing.Question, on_replace: :delete

    belongs_to :student, FactFluency.Students.Student

    timestamps()
  end

  @doc false
  def changeset(%Test{} = test, attrs) do
    test
    |> cast(attrs, [:start_time, :end_time, :review_start_time, :timestamps])
    |> validate_required([:start_time, :end_time, :review_start_time, :timestamps])
  end

  @doc """
  A test is created using parameters that can be set for a school, teacher, class, or student.
  The more specific parameters take precedence. For Example, a school could have a time limit parameter of 75 seconds-
  while a teacher might have a time limit of 60. Any new tests created for that teacher would then have a time limit-
  of 60 seconds.

  An error will be thrown if the `test_parameters` are not completed after being distilled.
  """
  @spec new_test(String.t(), map(), integer()) :: %Test{}
  def new_test(test_type, arguments, student_id) do

    test_parameters = 
      %TestParameters{test_type: test_type, arguments: arguments}
      |> TestParameters.create_test_parameters(student_id)

    case test_type do

    "elementary_arithmetic" ->
      {:ok, Arithmetic.create_test(test_parameters, student_id)}

    other -> 
      {:error, "#{other} is not yet implemented."}
    end
  end
end

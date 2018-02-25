defmodule FactFluency.Testing.TestParameters do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias FactFluency.Testing.TestParameters
  alias FactFluency.Students.Student
  alias FactFluency.Teachers.Teacher
  alias FactFluency.Institution.{School, Class}
  alias FactFluency.Repo


  schema "test_parameters" do
    field :arguments, :map
    field :include_random_questions_in_score, :boolean, default: false
    field :number_of_random_questions, :integer
    field :test_type, :string
    field :time_limit, :integer
    field :timestamps, :string
    field :total_questions, :integer
    field :warm_up, :boolean, default: false

    belongs_to :school, FactFluency.Institution.Class
    belongs_to :teacher, FactFluency.Teachers.Teacher
    belongs_to :class, FactFluency.Institution.Class
    belongs_to :student, FactFluency.Students.Student

    timestamps()
  end

  @doc false
  def changeset(%TestParameters{} = test_parameters, attrs) do
    test_parameters
    |> cast(attrs, [:test_type, :arguments, :total_questions, :number_of_random_questions, :include_random_questions_in_score, :time_limit, :warm_up, :school_id, :teacher_id, :class_id, :student_id])
  end

  @doc """
  Returns a distilled TestParameters struct.
  """
  @spec distill_test_parameters(%TestParameters{}, integer()) :: %TestParameters{}
  def distill_test_parameters(test_parameters, student_id) do
    parameters_list = student_params(student_id) ++ [test_parameters]

    distilled_parameters =
      if length(parameters_list) > 1 do
        Enum.reduce(parameters_list, List.first(parameters_list), fn(new, complete) ->
          complete
          |> Map.put(:include_random_questions_in_score, new.include_random_questions_in_score || complete.include_random_questions_in_score)
          |> Map.put(:number_of_random_questions, new.number_of_random_questions || complete.number_of_random_questions)
          |> Map.put(:test_type, new.test_type || complete.test_type)
          |> Map.put(:time_limit, new.time_limit || complete.time_limit)
          |> Map.put(:total_questions, new.total_questions || complete.total_questions)
          |> Map.put(:warm_up, new.warm_up || complete.warm_up)
          |> Map.put(:arguments, new.arguments || complete.arguments)
        end)
      else
        List.first(parameters_list)
      end
    
      if params_completed?(distilled_parameters) do
        {:ok, distilled_parameters}
      else
        {:error, "Incomplete test parameters for student with the id of: #{student_id}"}
      end
  end

  @spec student_params(integer()) :: list(%TestParameters{})
  defp student_params(student_id) do
    query = from st in Student,
      where: st.id == ^student_id,
      left_join: c in Class, 
        on: st.class_id == c.id,
      left_join: t in Teacher, 
        on: c.teacher_id == t.id,
      left_join: s in School, 
        on: t.school_id == s.id,
      left_join: p in TestParameters, 
        on: p.student_id == st.id or p.class_id == c.id or p.teacher_id == t.id or p.school_id == s.id,
      order_by: [p.school_id, p.teacher_id, p.class_id, p.student_id],
      select: p

    Repo.all(query)
  end

  @spec params_completed?(%TestParameters{}) :: :atom
  defp params_completed?(test_parameters) do
    #if Enum.any?(Map.values(distilled_parameters), fn(value) -> IO.inspect(value) == nil end) do
    #  false
    #else
    #  true
    #end

    true
  end
end

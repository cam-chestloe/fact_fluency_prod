defmodule FactFluency.Testing.ElementaryArithmetic do
  alias FactFluency.Testing.{TestParameters, Question, Test}

  # TODO: Learn how to define a behavior for a test type.
  # This should include being a struct that contains test arguments
  # Should also include creating tests and warmups
  # Should also include grading questions

  @doc """
  Creates an Elementary Arithmetic test.

  arguments must include:
  - number
  - operator
  """
  @spec create_test(%TestParameters{}, integer()) :: %Test{}
  def create_test(%TestParameters{arguments: arguments} = test_parameters, student_id) do
    validate_arguments(arguments)
    
    %Test{
      student_id: student_id,
      questions: create_questions(test_parameters),
      test_type: "elementary_arithmetic"
    }
  end

  @doc """
  Returns a list of questions.
  """
  @spec create_questions(%TestParameters{}) :: list(%Question{})
  def create_questions(test_parameters) do

    # Addition, subtraction and multiplication will feature numbers 0 - 12 (max_number?)
    # Division will feature any numbers divisible by the number up to number * 12 (max_number?)
    %{operator: operator, number: number} = test_parameters.arguments
    %{total_questions: total} = test_parameters

    # Forget adding random questions for now
    questions = add_questions([], Enum.to_list(0..12), number, total, operator)

    questions |> Enum.map(&(%Question{question: &1}))
  end

  @doc """
  Adds the correct answer to each question.
  """
  @spec grade_questions([%Question{}]) :: [%Question{}]
  def grade_questions(questions) do
    questions |> Enum.map(fn(question) ->
      {:ok, answer} = Abacus.eval(question.question)
      Map.put(question, :correct_answer, to_string(answer))
    end)
  end

  @spec add_questions([String.t()], [integer], integer, integer, String.t()) :: [String.t()]
  defp add_questions(questions, valid_numbers, number, total, operator) do
    length_of_questions = length(questions)
    length_of_valid_numbers = length(valid_numbers)

    if length_of_questions < total do

      if length_of_valid_numbers > length_of_questions do
        questions
          |> List.insert_at(0, "#{number} #{operator} #{Enum.at(valid_numbers, length_of_questions)}")
          |> add_questions(valid_numbers, number, total, operator)
      else
        questions
          |> List.insert_at(0, "#{number} #{operator} #{Enum.random(valid_numbers)}")
          |> add_questions(valid_numbers, number, total, operator)
      end

    else
      questions
    end
  end

  @spec add_random_questions([String.t()], String.t(), integer(), integer()) :: [String.t()]
  defp add_random_questions(questions, operator, total, number) do

    if length(questions) < total do
      List.insert_at(questions, 0, "#{:rand.uniform(12)} #{operator} #{number}")
      |> add_random_questions(operator, total, number)
      
    else questions end
  end

  @spec validate_arguments(map()) :: :ok
  defp validate_arguments(%{number: number, operator: operator}) do
    if not(is_integer(number)), do: raise(FunctionClauseError, [])
    if not(Enum.member?(['+', '-', '/', '*'], operator)), do: raise(FunctionClauseError, [])

    :ok
  end
end
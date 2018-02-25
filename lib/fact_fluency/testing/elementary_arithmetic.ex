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

    %{operator: operator, number: number} = test_parameters.arguments
    %{number_of_random_questions: rand, total_questions: total} = test_parameters
    
    # Addition, subtraction and multiplication will feature numbers 0 - 12 (max_number?)
    # Division will feature any numbers divisible by the number up to number * 12 (max_number?)
    valid_numbers = 
      if operator == "/" do
        Enum.to_list(0..12)
        |> Enum.map(fn(num) -> num * number end)
      else
        Enum.to_list(0..12)
      end

    questions = 
      []
      |> add_questions(valid_numbers, number, total - rand, operator)
      |> add_random_questions(valid_numbers, total, operator)

    questions |> Enum.map(&(%Question{question: &1}))
  end

  @doc """
  Adds the correct answer to each question.
  """
  @spec grade_questions([%Question{}]) :: [%Question{}]
  def grade_questions(questions) do
    questions |> Enum.map(fn(question) ->

      # handle division by zeros
      {:ok, answer} = 
        if String.contains?(question.question, "/") and String.contains?(question.question, "0") do
          {:ok, 0}
        else
          Abacus.eval(question.question)
        end

      Map.put(question, :correct_answer, to_string(answer))
    end)
  end

  @spec add_questions([String.t()], [integer], integer, integer, String.t()) :: [String.t()]
  defp add_questions(questions, valid_numbers, number, total, operator) when length(questions) < total do
    length_of_questions = length(questions)
    length_of_valid_numbers = length(valid_numbers)

    other_number = 
      if length_of_valid_numbers > length_of_questions do
        Enum.at(valid_numbers, length_of_questions)
      # If `questions` already contain one of each `valid_numbers`
      # add a random number from `valid_numbers`
      else
        Enum.random(valid_numbers)
      end

    # Keep larger numbers on top, for division and subtraction questions.
    question = 
      if (operator == "/" or operator == "-") and other_number > number do
        "#{other_number} #{operator} #{number}"
      else
        "#{number} #{operator} #{other_number}"
      end

    questions
      |> List.insert_at(0, question)
      |> add_questions(valid_numbers, number, total, operator)
  end

  @spec add_questions([String.t()], [integer], integer, integer, String.t()) :: [String.t()]
  defp add_questions(questions, _valid_numbers, _number, _total, _operator) do questions end

  @spec add_random_questions([String.t()], [integer], integer, String.t()) :: [String.t()]
  defp add_random_questions(questions, valid_numbers, total, operator) when length(questions) < total do
    num1 = 
      if operator == "/" do
        Enum.random(0..12)
      else
        Enum.random(valid_numbers)
      end
    
    num2 = 
      case operator do
        "/" -> num1 * Enum.random(1..12)
        "-" -> if num1 < 12, do: Enum.random(num1..12), else: 12
        _ -> Enum.random(valid_numbers)
      end

    List.insert_at(questions, 0, "#{num2} #{operator} #{num1}")
    |> add_random_questions(valid_numbers, total, operator)
  end

  @spec add_random_questions([String.t()], [integer], integer, String.t()) :: [String.t()]
  defp add_random_questions(questions, _valid_numbers, _total, _operator) do questions end

  @spec validate_arguments(map()) :: :ok
  defp validate_arguments(%{number: number, operator: operator}) do
    if not(is_integer(number)), do: raise("Argument number must be an integer.")
    if not(Enum.member?(["+", "-", "/", "*"], operator)), do: raise("Argument operator must be one of: +, -, * or /")

    :ok
  end
end
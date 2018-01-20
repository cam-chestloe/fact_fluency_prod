defmodule FactFluency.Testing.ElementaryArithmetic do
    alias FactFluency.Testing.{TestParameters, Question, Test}
  
    # TODO: Learn how to define a behavior for a test type.
    # This should include being a struct that contains test arguments
    # Should also include creating tests and warmups
  
    @doc """
    Creates an Elementary Arithmetic test.
  
    arguments must include:
    - number
    - operator
    """
    @spec create_test(%TestParameters{}, integer()) :: %Test{}
    def create_test(test_parameters, student_id) do
      %Test{
        student_id: student_id,
        questions: create_questions(test_parameters)
      }
    end
  
    @doc """
    Returns a list of questions.
    """
    @spec create_questions(%TestParameters{}) :: list(%Question{})
    def create_questions(test_parameters) do
  
      %{operator: operator, number: number} = test_parameters.arguments
      %{number_of_random_questions: rand, total_questions: total} = test_parameters
      numbers = Enum.to_list(0..number)

      numbers ++ Enum.take_random(numbers, total - number - rand - 1)
      |> Enum.map(&("#{&1} #{operator} #{number}"))
      |> add_random_questions(operator, total, number)
      |> Enum.map(fn(q) ->
        {:ok, answer} = Abacus.eval(q)
        %Question{question: q, correct_answer: Integer.to_string(answer)}
      end)
    end
  
    @spec add_random_questions([String.t()], String.t(), integer(), integer()) :: [String.t()]
    defp add_random_questions(questions, operator, total, number) do
  
      if length(questions) < total do
        List.insert_at(questions, 0, "#{:rand.uniform(number)} #{operator} #{number}")
        |> add_random_questions(operator, total, number)
        
      else questions end
    end
  end
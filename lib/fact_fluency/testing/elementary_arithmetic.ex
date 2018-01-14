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
      
      standard_questions =
        0..number
        |> Enum.map(&("#{&1} #{operator} #{number}"))
  
      backwards_questions = 
        0..number
        |> Enum.map(&("#{number} #{operator} #{&1}"))
        |> Enum.take_random(test_parameters.total_questions - (test_parameters.number_of_random_questions + number))
  
        standard_questions ++ backwards_questions
        |> add_random_questions(test_parameters)
        |> Enum.map(fn(q) ->
          {:ok, answer} = Abacus.eval(q)
          %Question{question: q, correct_answer: Integer.to_string(answer)}
        end)
    end
  
    @spec add_random_questions([String.t()], %TestParameters{}) :: [String.t()]
    defp add_random_questions(questions, test_parameters) do
      %{total_questions: total_questions, arguments: %{operator: operator, number: number}} = test_parameters
  
      if length(questions) < total_questions do
        List.insert_at(questions, 0, "#{:rand.uniform(number)} #{operator} #{number}")
        |> add_random_questions(test_parameters)
        
      else questions end
    end
  end
defmodule FactFluency.TestingElementaryArithmetic do
    use FactFluency.DataCase, async: true
    alias FactFluency.Testing.TestParameters
    alias FactFluency.Testing.{ElementaryArithmetic, Test}

    @valid_test_params %TestParameters{arguments: %{number: 5, operator: "+"}, include_random_questions_in_score: true, number_of_random_questions: 5, test_type: "elementary_arithmetic", time_limit: 60, timestamps: "some timestamps", total_questions: 12, warm_up: false}

    describe "create_test/2" do
        test "with valid arguments" do
            test_parameters = 
                @valid_test_params
                |> Map.put(:arguments, %{number: 6, operator: "-"})

            assert ElementaryArithmetic.create_test(test_parameters, 1)
        end

        test "with invalid argument keys raises an error" do
            test_parameters = 
                @valid_test_params
                |> Map.put(:arguments, %{invalid: 3, keys: "+"})

            assert_raise FunctionClauseError,  fn ->
                ElementaryArithmetic.create_test(test_parameters, 1)
            end
        end

        test "with invalid number argument value raises an error" do
            test_parameters = 
                @valid_test_params
                |> Map.put(:arguments, %{number: 't', operator: "+"})

            assert_raise RuntimeError, "Argument number must be an integer.", fn ->
                ElementaryArithmetic.create_test(test_parameters, 1)
            end
        end

        test "with invalid operator argument value raises an error" do
            test_parameters = 
                @valid_test_params
                |> Map.put(:arguments, %{number: 5, operator: "t"})

            assert_raise RuntimeError, "Argument operator must be one of: +, -, * or /", fn ->
                ElementaryArithmetic.create_test(test_parameters, 1)
            end
        end

        test "with the correct number of questions" do
            test_parameters =
                @valid_test_params
                |> Map.put(:total_questions, 5)
                |> Map.put(:number_of_random_questions, 0)

            %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)
        
            assert length(questions) == 5
        end

        test "with the correct number of questions including random questions" do
            test_parameters =
                @valid_test_params
                |> Map.put(:total_questions, 10)
                |> Map.put(:number_of_random_questions, 5)

            %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)

            assert length(questions) == 10
        end

        test "with the correct operators" do
            Enum.each(["+", "-", "*", "/"], fn(operator) ->
                test_parameters =
                    @valid_test_params
                    |> Map.put(:arguments, %{number: 0, operator: operator})
                
                %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)
                
                [_num1, op, _num2] =
                    List.first(questions).question
                    |> String.split()

                assert op == operator
            end)
        end

        test "with a larger numerator for division tests" do
            test_parameters =
                @valid_test_params
                |> Map.put(:arguments, %{number: 5, operator: "/"})

            %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)

            Enum.each(questions, fn(question) ->
               [num1, _operator, num2] = String.split(question.question)
               
               assert String.to_integer(num1) >= String.to_integer(num2)
            end)
        end

        test "with a larger number on top for subtraction tests" do
            test_parameters =
                @valid_test_params
                |> Map.put(:arguments, %{number: 5, operator: "-"})

            %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)

            Enum.each(questions, fn(question) ->
               [num1, _operator, num2] = String.split(question.question)
               
               assert String.to_integer(num1) >= String.to_integer(num2)
            end)
        end

        test "with the number zero contains all other numbers" do
            test_parameters =
                @valid_test_params
                |> Map.put(:arguments, %{number: 0, operator: "/"})
                |> Map.put(:number_of_random_questions: 0)
                |> Map.put(:total_questions, 12)

            %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)

            Enum.all?(questions, fn(question) ->
                
            end)
        end
    end

    describe "grade_questions/1" do
        test "with a division by zero problem" do
            test_parameters =
                @valid_test_params
                |> Map.put(:arguments, %{number: 0, operator: "/"})

            %Test{questions: questions} = ElementaryArithmetic.create_test(test_parameters, 1)

            assert ElementaryArithmetic.grade_questions(questions)
        end
    end
end

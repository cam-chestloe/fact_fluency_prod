defmodule FactFluency.TestingElementaryArithmetic do
    use FactFluency.DataCase, async: true
    
    describe "when creating an elementary arithmetic test for a student" do
      alias FactFluency.Testing.TestParameters
      alias FactFluency.Testing.ElementaryArithmetic
  
      @valid_test_params %TestParameters{arguments: %{}, include_random_questions_in_score: true, number_of_random_questions: 5, test_type: "elementary_arithmetic", time_limit: 60, timestamps: "some timestamps", total_questions: 12, warm_up: false}
  
      test "create_test/0 with valid arguments creates a test" do
        test_parameters = 
            @valid_test_params
            |> Map.put(:arguments, %{number: 5, operator: '+'})

        assert ElementaryArithmetic.create_test(test_parameters, 1)
      end

      test "create_test/1 with invalid argument keys raises an error" do
        test_parameters = 
            @valid_test_params
            |> Map.put(:arguments, %{invalid: 't', keys: 3})

        assert_raise FunctionClauseError,  fn ->
            ElementaryArithmetic.create_test(test_parameters, 1)
        end
      end

      test "create_test/2 with invalid argument values raises an error" do
        test_parameters = 
            @valid_test_params
            |> Map.put(:arguments, %{number: 't', operator: 3})

        assert_raise FunctionClauseError, fn ->
            ElementaryArithmetic.create_test(test_parameters, 1)
        end
      end

      test "create_test/3 creates a test with the correct number of standard questions" do
          
      end

      test "create_test/4 creates a test with the correct number of random questions" do
          
      end

      test "create_test/5 creates a test with the correct number of standard and random questions" do
          
      end

      test "create_test/6 creates a test with the correct operators" do
          
      end
    end
  end
  
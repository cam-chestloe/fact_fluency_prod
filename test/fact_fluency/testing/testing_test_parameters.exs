defmodule FactFluency.TestingTest do
    use FactFluency.DataCase
  
    alias FactFluency.Testing
  
    describe "test_parameters" do
      alias FactFluency.Testing.TestParameters
  
      @valid_attrs %{arguments: %{}, include_random_questions_in_score: true, number_of_random_questions: 3, test_type: "elementary_arithmetic", time_limit: 60, total_questions: 13, warm_up: true}
      @update_attrs %{arguments: %{}, include_random_questions_in_score: false, number_of_random_questions: 5, test_type: "elementary_arithmetic", time_limit: 65, total_questions: 15, warm_up: false}
      @invalid_attrs %{arguments: nil, include_random_questions_in_score: "test", number_of_random_questions: nil, test_type: nil, time_limit: nil, timestamps: nil, total_questions: nil, warm_up: nil}
  
      def test_parameters_fixture(attrs \\ %{}) do
        {:ok, test_parameters} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Testing.create_test_parameters()
  
        test_parameters
      end
  
      test "list_test_parameters/0 returns all test_parameters" do
        test_parameters = test_parameters_fixture()
        assert Testing.list_test_parameters() == [test_parameters]
      end
  
      test "get_test_parameters!/1 returns the test_parameters with given id" do
        test_parameters = test_parameters_fixture()
        assert Testing.get_test_parameters!(test_parameters.id) == test_parameters
      end
  
      test "create_test_parameters/1 with valid data creates a test_parameters" do
        assert {:ok, %TestParameters{} = test_parameters} = Testing.create_test_parameters(@valid_attrs)
        assert test_parameters.arguments == %{}
        assert test_parameters.include_random_questions_in_score == true
        assert test_parameters.number_of_random_questions == 3
        assert test_parameters.test_type == "elementary_arithmetic"
        assert test_parameters.time_limit == 60
        assert test_parameters.total_questions == 13
        assert test_parameters.warm_up == true
      end
  
      test "create_test_parameters/1 with invalid data returns error changeset" do
        assert {:error, %Ecto.Changeset{}} = Testing.create_test_parameters(@invalid_attrs)
      end
  
      test "update_test_parameters/2 with valid data updates the test_parameters" do
        test_parameters = test_parameters_fixture()
        assert {:ok, test_parameters} = Testing.update_test_parameters(test_parameters, @update_attrs)
        assert %TestParameters{} = test_parameters
        assert test_parameters.arguments == %{}
        assert test_parameters.include_random_questions_in_score == false
        assert test_parameters.number_of_random_questions == 5
        assert test_parameters.test_type == "elementary_arithmetic"
        assert test_parameters.time_limit == 65
        assert test_parameters.total_questions == 15
        assert test_parameters.warm_up == false
      end
  
      test "update_test_parameters/2 with invalid data returns error changeset" do
        test_parameters = test_parameters_fixture()
        assert {:error, %Ecto.Changeset{}} = Testing.update_test_parameters(test_parameters, @invalid_attrs)
        assert test_parameters == Testing.get_test_parameters!(test_parameters.id)
      end
  
      test "delete_test_parameters/1 deletes the test_parameters" do
        test_parameters = test_parameters_fixture()
        assert {:ok, %TestParameters{}} = Testing.delete_test_parameters(test_parameters)
        assert_raise Ecto.NoResultsError, fn -> Testing.get_test_parameters!(test_parameters.id) end
      end
  
      test "change_test_parameters/1 returns a test_parameters changeset" do
        test_parameters = test_parameters_fixture()
        assert %Ecto.Changeset{} = Testing.change_test_parameters(test_parameters)
      end
    end

    describe "student_params/1" do
        test ""
    end
  end
  
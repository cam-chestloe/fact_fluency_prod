defmodule FactFluency.TestingTest do
  use FactFluency.DataCase

  alias FactFluency.Testing

  describe "test_parameters" do
    alias FactFluency.Testing.TestParameters

    @valid_attrs %{arguments: %{}, include_random_questions_in_score: true, number_of_random_questions: 42, test_type: "some test_type", time_limit: 42, timestamps: "some timestamps", total_questions: 42, warm_up: true}
    @update_attrs %{arguments: %{}, include_random_questions_in_score: false, number_of_random_questions: 43, test_type: "some updated test_type", time_limit: 43, timestamps: "some updated timestamps", total_questions: 43, warm_up: false}
    @invalid_attrs %{arguments: nil, include_random_questions_in_score: nil, number_of_random_questions: nil, test_type: nil, time_limit: nil, timestamps: nil, total_questions: nil, warm_up: nil}

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
      assert test_parameters.number_of_random_questions == 42
      assert test_parameters.test_type == "some test_type"
      assert test_parameters.time_limit == 42
      assert test_parameters.timestamps == "some timestamps"
      assert test_parameters.total_questions == 42
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
      assert test_parameters.number_of_random_questions == 43
      assert test_parameters.test_type == "some updated test_type"
      assert test_parameters.time_limit == 43
      assert test_parameters.timestamps == "some updated timestamps"
      assert test_parameters.total_questions == 43
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

  describe "tests" do
    alias FactFluency.Testing.Test

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], review_start_time: ~N[2010-04-17 14:00:00.000000], start_time: ~N[2010-04-17 14:00:00.000000], timestamps: "some timestamps"}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], review_start_time: ~N[2011-05-18 15:01:01.000000], start_time: ~N[2011-05-18 15:01:01.000000], timestamps: "some updated timestamps"}
    @invalid_attrs %{end_time: nil, review_start_time: nil, start_time: nil, timestamps: nil}

    def test_fixture(attrs \\ %{}) do
      {:ok, test} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Testing.create_test()

      test
    end

    test "list_tests/0 returns all tests" do
      test = test_fixture()
      assert Testing.list_tests() == [test]
    end

    test "get_test!/1 returns the test with given id" do
      test = test_fixture()
      assert Testing.get_test!(test.id) == test
    end

    test "create_test/1 with valid data creates a test" do
      assert {:ok, %Test{} = test} = Testing.create_test(@valid_attrs)
      assert test.end_time == ~N[2010-04-17 14:00:00.000000]
      assert test.review_start_time == ~N[2010-04-17 14:00:00.000000]
      assert test.start_time == ~N[2010-04-17 14:00:00.000000]
      assert test.timestamps == "some timestamps"
    end

    test "create_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Testing.create_test(@invalid_attrs)
    end

    test "update_test/2 with valid data updates the test" do
      test = test_fixture()
      assert {:ok, test} = Testing.update_test(test, @update_attrs)
      assert %Test{} = test
      assert test.end_time == ~N[2011-05-18 15:01:01.000000]
      assert test.review_start_time == ~N[2011-05-18 15:01:01.000000]
      assert test.start_time == ~N[2011-05-18 15:01:01.000000]
      assert test.timestamps == "some updated timestamps"
    end

    test "update_test/2 with invalid data returns error changeset" do
      test = test_fixture()
      assert {:error, %Ecto.Changeset{}} = Testing.update_test(test, @invalid_attrs)
      assert test == Testing.get_test!(test.id)
    end

    test "delete_test/1 deletes the test" do
      test = test_fixture()
      assert {:ok, %Test{}} = Testing.delete_test(test)
      assert_raise Ecto.NoResultsError, fn -> Testing.get_test!(test.id) end
    end

    test "change_test/1 returns a test changeset" do
      test = test_fixture()
      assert %Ecto.Changeset{} = Testing.change_test(test)
    end
  end
end

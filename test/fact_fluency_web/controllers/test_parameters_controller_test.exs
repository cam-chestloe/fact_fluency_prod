defmodule FactFluencyWeb.TestParametersControllerTest do
  use FactFluencyWeb.ConnCase

  alias FactFluency.Testing

  @create_attrs %{arguments: %{}, include_random_questions_in_score: true, number_of_random_questions: 42, test_type: "some test_type", time_limit: 42, timestamps: "some timestamps", total_questions: 42, warm_up: true}
  @update_attrs %{arguments: %{}, include_random_questions_in_score: false, number_of_random_questions: 43, test_type: "some updated test_type", time_limit: 43, timestamps: "some updated timestamps", total_questions: 43, warm_up: false}
  @invalid_attrs %{arguments: nil, include_random_questions_in_score: nil, number_of_random_questions: nil, test_type: nil, time_limit: nil, timestamps: nil, total_questions: nil, warm_up: nil}

  def fixture(:test_parameters) do
    {:ok, test_parameters} = Testing.create_test_parameters(@create_attrs)
    test_parameters
  end

  describe "index" do
    test "lists all test_parameters", %{conn: conn} do
      conn = get conn, test_parameters_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Test parameters"
    end
  end

  describe "new test_parameters" do
    test "renders form", %{conn: conn} do
      conn = get conn, test_parameters_path(conn, :new)
      assert html_response(conn, 200) =~ "New Test parameters"
    end
  end

  describe "create test_parameters" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, test_parameters_path(conn, :create), test_parameters: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == test_parameters_path(conn, :show, id)

      conn = get conn, test_parameters_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Test parameters"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, test_parameters_path(conn, :create), test_parameters: @invalid_attrs
      assert html_response(conn, 200) =~ "New Test parameters"
    end
  end

  describe "edit test_parameters" do
    setup [:create_test_parameters]

    test "renders form for editing chosen test_parameters", %{conn: conn, test_parameters: test_parameters} do
      conn = get conn, test_parameters_path(conn, :edit, test_parameters)
      assert html_response(conn, 200) =~ "Edit Test parameters"
    end
  end

  describe "update test_parameters" do
    setup [:create_test_parameters]

    test "redirects when data is valid", %{conn: conn, test_parameters: test_parameters} do
      conn = put conn, test_parameters_path(conn, :update, test_parameters), test_parameters: @update_attrs
      assert redirected_to(conn) == test_parameters_path(conn, :show, test_parameters)

      conn = get conn, test_parameters_path(conn, :show, test_parameters)
      assert html_response(conn, 200) =~ "some updated test_type"
    end

    test "renders errors when data is invalid", %{conn: conn, test_parameters: test_parameters} do
      conn = put conn, test_parameters_path(conn, :update, test_parameters), test_parameters: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Test parameters"
    end
  end

  describe "delete test_parameters" do
    setup [:create_test_parameters]

    test "deletes chosen test_parameters", %{conn: conn, test_parameters: test_parameters} do
      conn = delete conn, test_parameters_path(conn, :delete, test_parameters)
      assert redirected_to(conn) == test_parameters_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, test_parameters_path(conn, :show, test_parameters)
      end
    end
  end

  defp create_test_parameters(_) do
    test_parameters = fixture(:test_parameters)
    {:ok, test_parameters: test_parameters}
  end
end

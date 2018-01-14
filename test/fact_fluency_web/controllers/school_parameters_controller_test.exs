defmodule FactFluencyWeb.SchoolParametersControllerTest do
  use FactFluencyWeb.ConnCase

  alias FactFluency.Institution

  @create_attrs %{teachers_can_edit_test_parameters: true, teachers_can_edit_warmup_parameters: true}
  @update_attrs %{teachers_can_edit_test_parameters: false, teachers_can_edit_warmup_parameters: false}
  @invalid_attrs %{teachers_can_edit_test_parameters: nil, teachers_can_edit_warmup_parameters: nil}

  def fixture(:school_parameters) do
    {:ok, school_parameters} = Institution.create_school_parameters(@create_attrs)
    school_parameters
  end

  describe "index" do
    test "lists all school_parameters", %{conn: conn} do
      conn = get conn, school_parameters_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing School parameters"
    end
  end

  describe "new school_parameters" do
    test "renders form", %{conn: conn} do
      conn = get conn, school_parameters_path(conn, :new)
      assert html_response(conn, 200) =~ "New School parameters"
    end
  end

  describe "create school_parameters" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, school_parameters_path(conn, :create), school_parameters: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == school_parameters_path(conn, :show, id)

      conn = get conn, school_parameters_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show School parameters"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, school_parameters_path(conn, :create), school_parameters: @invalid_attrs
      assert html_response(conn, 200) =~ "New School parameters"
    end
  end

  describe "edit school_parameters" do
    setup [:create_school_parameters]

    test "renders form for editing chosen school_parameters", %{conn: conn, school_parameters: school_parameters} do
      conn = get conn, school_parameters_path(conn, :edit, school_parameters)
      assert html_response(conn, 200) =~ "Edit School parameters"
    end
  end

  describe "update school_parameters" do
    setup [:create_school_parameters]

    test "redirects when data is valid", %{conn: conn, school_parameters: school_parameters} do
      conn = put conn, school_parameters_path(conn, :update, school_parameters), school_parameters: @update_attrs
      assert redirected_to(conn) == school_parameters_path(conn, :show, school_parameters)

      conn = get conn, school_parameters_path(conn, :show, school_parameters)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, school_parameters: school_parameters} do
      conn = put conn, school_parameters_path(conn, :update, school_parameters), school_parameters: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit School parameters"
    end
  end

  describe "delete school_parameters" do
    setup [:create_school_parameters]

    test "deletes chosen school_parameters", %{conn: conn, school_parameters: school_parameters} do
      conn = delete conn, school_parameters_path(conn, :delete, school_parameters)
      assert redirected_to(conn) == school_parameters_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, school_parameters_path(conn, :show, school_parameters)
      end
    end
  end

  defp create_school_parameters(_) do
    school_parameters = fixture(:school_parameters)
    {:ok, school_parameters: school_parameters}
  end
end

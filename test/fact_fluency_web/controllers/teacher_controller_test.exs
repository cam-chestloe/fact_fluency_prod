defmodule FactFluencyWeb.TeacherControllerTest do
  use FactFluencyWeb.ConnCase

  alias FactFluency.Teachers

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", timestamps: "some timestamps"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", timestamps: "some updated timestamps"}
  @invalid_attrs %{first_name: nil, last_name: nil, timestamps: nil}

  def fixture(:teacher) do
    {:ok, teacher} = Teachers.create_teacher(@create_attrs)
    teacher
  end

  describe "index" do
    test "lists all teachers", %{conn: conn} do
      conn = get conn, teacher_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Teachers"
    end
  end

  describe "new teacher" do
    test "renders form", %{conn: conn} do
      conn = get conn, teacher_path(conn, :new)
      assert html_response(conn, 200) =~ "New Teacher"
    end
  end

  describe "create teacher" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, teacher_path(conn, :create), teacher: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == teacher_path(conn, :show, id)

      conn = get conn, teacher_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Teacher"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, teacher_path(conn, :create), teacher: @invalid_attrs
      assert html_response(conn, 200) =~ "New Teacher"
    end
  end

  describe "edit teacher" do
    setup [:create_teacher]

    test "renders form for editing chosen teacher", %{conn: conn, teacher: teacher} do
      conn = get conn, teacher_path(conn, :edit, teacher)
      assert html_response(conn, 200) =~ "Edit Teacher"
    end
  end

  describe "update teacher" do
    setup [:create_teacher]

    test "redirects when data is valid", %{conn: conn, teacher: teacher} do
      conn = put conn, teacher_path(conn, :update, teacher), teacher: @update_attrs
      assert redirected_to(conn) == teacher_path(conn, :show, teacher)

      conn = get conn, teacher_path(conn, :show, teacher)
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, teacher: teacher} do
      conn = put conn, teacher_path(conn, :update, teacher), teacher: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Teacher"
    end
  end

  describe "delete teacher" do
    setup [:create_teacher]

    test "deletes chosen teacher", %{conn: conn, teacher: teacher} do
      conn = delete conn, teacher_path(conn, :delete, teacher)
      assert redirected_to(conn) == teacher_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, teacher_path(conn, :show, teacher)
      end
    end
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    {:ok, teacher: teacher}
  end
end

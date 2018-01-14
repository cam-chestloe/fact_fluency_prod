defmodule FactFluencyWeb.ParentControllerTest do
  use FactFluencyWeb.ConnCase

  alias FactFluency.Parents

  @create_attrs %{email: "some email", first_name: "some first_name"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name"}
  @invalid_attrs %{email: nil, first_name: nil}

  def fixture(:parent) do
    {:ok, parent} = Parents.create_parent(@create_attrs)
    parent
  end

  describe "index" do
    test "lists all parents", %{conn: conn} do
      conn = get conn, parent_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Parents"
    end
  end

  describe "new parent" do
    test "renders form", %{conn: conn} do
      conn = get conn, parent_path(conn, :new)
      assert html_response(conn, 200) =~ "New Parent"
    end
  end

  describe "create parent" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, parent_path(conn, :create), parent: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == parent_path(conn, :show, id)

      conn = get conn, parent_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Parent"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, parent_path(conn, :create), parent: @invalid_attrs
      assert html_response(conn, 200) =~ "New Parent"
    end
  end

  describe "edit parent" do
    setup [:create_parent]

    test "renders form for editing chosen parent", %{conn: conn, parent: parent} do
      conn = get conn, parent_path(conn, :edit, parent)
      assert html_response(conn, 200) =~ "Edit Parent"
    end
  end

  describe "update parent" do
    setup [:create_parent]

    test "redirects when data is valid", %{conn: conn, parent: parent} do
      conn = put conn, parent_path(conn, :update, parent), parent: @update_attrs
      assert redirected_to(conn) == parent_path(conn, :show, parent)

      conn = get conn, parent_path(conn, :show, parent)
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, parent: parent} do
      conn = put conn, parent_path(conn, :update, parent), parent: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Parent"
    end
  end

  describe "delete parent" do
    setup [:create_parent]

    test "deletes chosen parent", %{conn: conn, parent: parent} do
      conn = delete conn, parent_path(conn, :delete, parent)
      assert redirected_to(conn) == parent_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, parent_path(conn, :show, parent)
      end
    end
  end

  defp create_parent(_) do
    parent = fixture(:parent)
    {:ok, parent: parent}
  end
end

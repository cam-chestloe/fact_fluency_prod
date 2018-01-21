defmodule FactFluencyWeb.TestController do
  use FactFluencyWeb, :controller
  use Drab.Controller

  alias FactFluency.Testing
  alias FactFluency.Testing.Test

  def index(conn, _params) do
    tests = Testing.list_tests()
    render(conn, "index.html", tests: tests)
  end

  def new(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    changeset = Testing.change_test(%Test{})
    render(conn, "new.html", [user: user, changeset: changeset])
  end

  def create(conn, %{"test" => test_params}) do
    case Testing.create_test(test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test created successfully.")
        |> take(%{"test" => test})

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def take(conn, %{"test" => test}) do
    conn
    |> put_session(:test_id, test.id)
    |> render("take.html", [question: List.first(test.questions), 
                           answer: "", 
                           index: 0])
  end

  def show(conn, %{"id" => id}) do
    test = Testing.get_test!(id)
    render(conn, "show.html", test: test)
  end

  def edit(conn, %{"id" => id}) do
    test = Testing.get_test!(id)
    changeset = Testing.change_test(test)
    render(conn, "edit.html", test: test, changeset: changeset)
  end

  def update(conn, %{"id" => id, "test" => test_params}) do
    test = Testing.get_test!(id)

    case Testing.update_test(test, test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test updated successfully.")
        |> redirect(to: test_path(conn, :show, test))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", test: test, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test = Testing.get_test!(id)
    {:ok, _test} = Testing.delete_test(test)

    conn
    |> put_flash(:info, "Test deleted successfully.")
    |> redirect(to: test_path(conn, :index))
  end

  
end

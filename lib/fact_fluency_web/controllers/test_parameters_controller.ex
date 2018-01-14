defmodule FactFluencyWeb.TestParametersController do
  use FactFluencyWeb, :controller

  alias FactFluency.Testing
  alias FactFluency.Testing.TestParameters

  def index(conn, _params) do
    test_parameters = Testing.list_test_parameters()
    render(conn, "index.html", test_parameters: test_parameters)
  end

  def new(conn, _params) do
    changeset = Testing.change_test_parameters(%TestParameters{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"test_parameters" => test_parameters_params}) do
    case Testing.create_test_parameters(test_parameters_params) do
      {:ok, test_parameters} ->
        conn
        |> put_flash(:info, "Test parameters created successfully.")
        |> redirect(to: test_parameters_path(conn, :show, test_parameters))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    test_parameters = Testing.get_test_parameters!(id)
    render(conn, "show.html", test_parameters: test_parameters)
  end

  def edit(conn, %{"id" => id}) do
    test_parameters = Testing.get_test_parameters!(id)
    changeset = Testing.change_test_parameters(test_parameters)
    render(conn, "edit.html", test_parameters: test_parameters, changeset: changeset)
  end

  def update(conn, %{"id" => id, "test_parameters" => test_parameters_params}) do
    test_parameters = Testing.get_test_parameters!(id)

    case Testing.update_test_parameters(test_parameters, test_parameters_params) do
      {:ok, test_parameters} ->
        conn
        |> put_flash(:info, "Test parameters updated successfully.")
        |> redirect(to: test_parameters_path(conn, :show, test_parameters))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", test_parameters: test_parameters, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test_parameters = Testing.get_test_parameters!(id)
    {:ok, _test_parameters} = Testing.delete_test_parameters(test_parameters)

    conn
    |> put_flash(:info, "Test parameters deleted successfully.")
    |> redirect(to: test_parameters_path(conn, :index))
  end
end

defmodule FactFluencyWeb.SchoolParametersController do
  use FactFluencyWeb, :controller

  alias FactFluency.Institution
  alias FactFluency.Institution.SchoolParameters

  def index(conn, _params) do
    school_parameters = Institution.list_school_parameters()
    render(conn, "index.html", school_parameters: school_parameters)
  end

  def new(conn, _params) do
    changeset = Institution.change_school_parameters(%SchoolParameters{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"school_parameters" => school_parameters_params}) do
    case Institution.create_school_parameters(school_parameters_params) do
      {:ok, school_parameters} ->
        conn
        |> put_flash(:info, "School parameters created successfully.")
        |> redirect(to: school_parameters_path(conn, :show, school_parameters))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    school_parameters = Institution.get_school_parameters!(id)
    render(conn, "show.html", school_parameters: school_parameters)
  end

  def edit(conn, %{"id" => id}) do
    school_parameters = Institution.get_school_parameters!(id)
    changeset = Institution.change_school_parameters(school_parameters)
    render(conn, "edit.html", school_parameters: school_parameters, changeset: changeset)
  end

  def update(conn, %{"id" => id, "school_parameters" => school_parameters_params}) do
    school_parameters = Institution.get_school_parameters!(id)

    case Institution.update_school_parameters(school_parameters, school_parameters_params) do
      {:ok, school_parameters} ->
        conn
        |> put_flash(:info, "School parameters updated successfully.")
        |> redirect(to: school_parameters_path(conn, :show, school_parameters))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", school_parameters: school_parameters, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    school_parameters = Institution.get_school_parameters!(id)
    {:ok, _school_parameters} = Institution.delete_school_parameters(school_parameters)

    conn
    |> put_flash(:info, "School parameters deleted successfully.")
    |> redirect(to: school_parameters_path(conn, :index))
  end
end

defmodule FactFluencyWeb.TeacherController do
  use FactFluencyWeb, :controller

  alias FactFluency.Teachers
  alias FactFluency.Teachers.Teacher
  alias FactFluency.Accounts
  alias FactFluency.Accounts.{Credential, User}

  def index(conn, _params) do
    teachers = Teachers.list_teachers()
    render(conn, "index.html", teachers: teachers)
  end

  def new(conn, _params) do
    changeset = Teachers.change_teacher(%Teacher{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    case Teachers.create_teacher(teacher_params) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher created successfully.")
        |> redirect(to: teacher_path(conn, :show, teacher))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher!(id)
    render(conn, "show.html", teacher: teacher)
  end

  def edit(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher!(id)
    changeset = Teachers.change_teacher(teacher)
    render(conn, "edit.html", teacher: teacher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Teachers.get_teacher!(id)

    case Teachers.update_teacher(teacher, teacher_params) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher updated successfully.")
        |> redirect(to: teacher_path(conn, :show, teacher))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", teacher: teacher, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher!(id)
    {:ok, _teacher} = Teachers.delete_teacher(teacher)

    conn
    |> put_flash(:info, "Teacher deleted successfully.")
    |> redirect(to: teacher_path(conn, :index))
  end
end

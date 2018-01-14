defmodule FactFluencyWeb.ParentController do
  use FactFluencyWeb, :controller

  alias FactFluency.Parents
  alias FactFluency.Parents.Parent

  def index(conn, _params) do
    parents = Parents.list_parents()
    render(conn, "index.html", parents: parents)
  end

  def new(conn, _params) do
    changeset = Parents.change_parent(%Parent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"parent" => parent_params}) do
    case Parents.create_parent(parent_params) do
      {:ok, parent} ->
        conn
        |> put_flash(:info, "Parent created successfully.")
        |> redirect(to: parent_path(conn, :show, parent))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    parent = Parents.get_parent!(id)
    render(conn, "show.html", parent: parent)
  end

  def edit(conn, %{"id" => id}) do
    parent = Parents.get_parent!(id)
    changeset = Parents.change_parent(parent)
    render(conn, "edit.html", parent: parent, changeset: changeset)
  end

  def update(conn, %{"id" => id, "parent" => parent_params}) do
    parent = Parents.get_parent!(id)

    case Parents.update_parent(parent, parent_params) do
      {:ok, parent} ->
        conn
        |> put_flash(:info, "Parent updated successfully.")
        |> redirect(to: parent_path(conn, :show, parent))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", parent: parent, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    parent = Parents.get_parent!(id)
    {:ok, _parent} = Parents.delete_parent(parent)

    conn
    |> put_flash(:info, "Parent deleted successfully.")
    |> redirect(to: parent_path(conn, :index))
  end
end

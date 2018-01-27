defmodule FactFluencyWeb.PageController do
  use FactFluencyWeb, :controller
  use Drab.Controller

  def index(conn, _params) do
    render conn, "index.html", conn: conn
  end

  def login(conn, %{"user" => %{ "email" => email, "password" => password, "user_type" => user_type}}) do

    case FactFluency.Accounts.authenticate_by_email_password(email, password, user_type) do
      {:ok, user} ->
          conn
          |> put_flash(:info, "Welcome back!")
          |> FactFluency.Guardian.Plug.sign_in(user, %{"user_type" => user_type})
          |> redirect(to: "/take")
      {:error, :unauthorized} ->
          conn
          |> put_flash(:error, "There was an error logging in.")
          |> redirect(to: "/")
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    conn
    |> FactFluency.Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end

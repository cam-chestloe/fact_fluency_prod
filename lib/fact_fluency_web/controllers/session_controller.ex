defmodule FactFluencyWeb.SessionController do
    use FactFluencyWeb, :controller

    alias FactFluency.Accounts

    def new(conn, _) do
        render(conn, "new.html")
    end

    def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
        case Accounts.authenticate_by_email_password(email, password) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> FactFluency.Guardian.Plug.sign_in(user)
                |> redirect(to: "/")
            {:error, :unauthorized} ->
                conn
                |> put_flash(:error, "Bad email/password combination")
                |> redirect(to: session_path(conn, :new))
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
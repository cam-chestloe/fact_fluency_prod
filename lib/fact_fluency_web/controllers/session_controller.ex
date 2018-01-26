defmodule FactFluencyWeb.SessionController do
    use FactFluencyWeb, :controller
    use Drab.Controller

    alias FactFluency.Accounts

    def new(conn, _) do
        render(conn, "new.html")
    end

    def create(conn, %{"user" => %{ "email" => email, "password" => password, "user_type" => user_type}}) do
        case Accounts.authenticate_by_email_password(email, password, user_type) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> FactFluency.Guardian.Plug.sign_in(user, %{"user_type" => user_type})
                |> redirect(to: "/")
            {:error, :unauthorized} ->
                conn
                |> put_flash(:error, "Bad email/password combination")
                |> render(FactFluencyWeb.SessionView, "new.html", user_type: user_type)
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
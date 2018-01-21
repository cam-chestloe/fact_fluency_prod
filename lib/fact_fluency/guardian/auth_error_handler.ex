defmodule FactFluency.AuthErrorHandler do
    use FactFluencyWeb, :controller

    def auth_error(conn, _params, _) do
        conn
        |> put_status(401)
        |> put_flash(:info, "Authentication required")
        |> redirect(to: "/")
    end
end
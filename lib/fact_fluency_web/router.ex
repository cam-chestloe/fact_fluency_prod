defmodule FactFluencyWeb.Router do
  use FactFluencyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FactFluencyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete], 
                                              singleton: true

    resources "/schools", SchoolController
    resources "/classes", ClassController
    resources "/teachers", TeacherController
    resources "/students", StudentController
    resources "/parents", ParentController
    resources "/school_parameters", SchoolParametersController
    resources "/test_parameters", TestParametersController
    resources "/tests", TestController
    get "/take", TestController, :take
  end

  # Other scopes may use custom stacks.
  # scope "/api", FactFluencyWeb do
  #   pipe_through :api
  # end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, FactFluency.Accounts.get_user!(user_id))
    end
  end
end

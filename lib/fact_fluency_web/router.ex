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

  pipeline :authenticate_student do
    plug Guardian.Plug.Pipeline, module: FactFluency.Guardian,
                                 error_handler: FactFluency.AuthErrorHandler

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access", "user_type" => "Student"}
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, ensure: true
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

    post "/login", PageController, :login
    delete "/logout", PageController, :logout

    scope "/take" do
      pipe_through :authenticate_student

      get "/", TestController, :new
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", FactFluencyWeb do
  #   pipe_through :api
  # end
end

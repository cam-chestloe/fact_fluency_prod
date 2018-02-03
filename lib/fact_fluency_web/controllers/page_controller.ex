defmodule FactFluencyWeb.PageController do
  use FactFluencyWeb, :controller
  use Drab.Controller

  def index(conn, _params) do
    render conn, "index.html", conn: conn
  end
end

defmodule FactFluencyWeb.PageController do
  use FactFluencyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

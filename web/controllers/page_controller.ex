defmodule ShoutApi.PageController do
  use ShoutApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

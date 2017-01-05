defmodule Lisztomania.PageController do
  use Lisztomania.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

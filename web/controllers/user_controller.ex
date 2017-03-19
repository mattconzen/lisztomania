defmodule Lisztomania.UserController do
 use Lisztomania.Web, :controller
 plug Lisztomania.Plugs.Auth

  def index(conn, %{"id" => user_id}) do
    text conn, "Hello #{user_id}"
  end

  def show(conn, %{"id" => user_id}) do
    text conn, "Hello #{user_id}"
  end
end
defmodule EpasWeb.Plugs.RequireAdmin do

  @moduledoc """
  Plug to validate with this user logged is admin
  """

  import Plug.Conn
  import Phoenix.Controller
  alias EpasWeb.Router.Helpers

  @doc """
  init is never used here
  """
  def init(_param) do
  end

  @doc """
  call this method validate in request time if this user is admin
  """
  def call(conn, _param) do
    if conn.assigns[:user].admin do
      conn
    else
      conn
      |> put_flash(:error, "You need to be a admin")
      |> redirect(to: Helpers.bucket_path(conn, :index))
      |> halt()
    end
  end

end

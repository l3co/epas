defmodule EpasWeb.Plugs.RequireAuth do

  @moduledoc """
  Plug used in request time to validate if user is logged
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
  call validate if the user is authenticated
  """
  def call(conn, _param) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.user_path(conn, :login))
      |> halt()
    end
  end

end

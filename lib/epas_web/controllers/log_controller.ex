defmodule EpasWeb.LogController do
  use EpasWeb, :controller

  alias Epas.Account

  plug EpasWeb.Plugs.RequireAuth, :logged
  plug EpasWeb.Plugs.RequireAdmin, :admin

  def index(conn, _params) do
    logs = Account.list_logs()
    render(conn, "index.html", logs: logs)
  end
end

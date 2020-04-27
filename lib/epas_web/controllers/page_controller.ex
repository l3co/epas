defmodule EpasWeb.PageController do
  use EpasWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

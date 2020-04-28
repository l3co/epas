defmodule EpasWeb.LogControllerTest do
  use EpasWeb.ConnCase

  alias Epas.Account

  @create_attrs %{info: "some info", operation: "some operation"}
  @update_attrs %{info: "some updated info", operation: "some updated operation"}
  @invalid_attrs %{info: nil, operation: nil}

  def fixture(:log) do
    {:ok, log} = Account.create_log(@create_attrs)
    log
  end

  setup %{conn: conn} do
    {:ok, user} =
      Account.create_user(%{
        admin: true,
        avatar: "some avatar",
        email: "some email",
        name: "some name",
        token: "some token"
      })

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: user.id)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all logs", %{conn: conn} do
      conn = get(conn, Routes.log_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Logs"
    end
  end

  defp create_log(_) do
    log = fixture(:log)
    {:ok, log: log}
  end
end

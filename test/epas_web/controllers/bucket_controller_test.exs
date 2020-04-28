defmodule EpasWeb.BucketControllerTest do
  use EpasWeb.ConnCase

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

end

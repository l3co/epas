defmodule EpasWeb.Plugs.SetUser do
  @moduledoc """
  Plug to set user from session
  """

  import Plug.Conn
  alias Epas.Account

  @doc """
  init is not used here
  """
  def init(_params) do
  end

  @doc """
  call method receive a conn and params and after find user by user id into sessions
  and set assign user in conn
  """
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    if user_id do
      user = Account.get_user!(user_id)

      if user do
        assign(conn, :user, user)
      end
    else
      assign(conn, :user, nil)
    end
  end
end

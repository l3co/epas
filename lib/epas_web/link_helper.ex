defmodule EpasWeb.LinkHelper do
  @moduledoc """
  Helper used to UI, show or hide menus
  """

  @doc """
  active method are used to highlight menu active
  """
  def active(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "is-active"
    else
      nil
    end
  end

  @doc """
  logged? show content pages just a user is logged
  """
  def logged?(conn), do: conn.assigns[:user] != nil

  @doc """
  admin? show content pages just a user is admin
  """
  def admin?(conn), do: conn.assigns[:user].admin
end

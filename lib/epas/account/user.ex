defmodule Epas.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :name, :string
    field :token, :string
    has_many :logs, Epas.Account.Log

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :admin, :token])
    |> validate_required([:name, :email, :admin, :token])
  end
end

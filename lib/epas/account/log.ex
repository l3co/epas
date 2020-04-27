defmodule Epas.Account.Log do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "logs" do
    field :info, :string
    field :operation, :string
    belongs_to :user, Epas.Account.User

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:operation, :info, :user_id])
    |> validate_required([:operation, :info, :user_id])
  end
end

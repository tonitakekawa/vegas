defmodule Ap.User do
  use Ap.Web, :model

  schema "users" do
    field :userId, :string
    field :hashedPassword, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:userId, :hashedPassword])
    |> validate_required([:userId, :hashedPassword])
  end
end

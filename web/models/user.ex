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
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
  %{password: password}} = changeset) do
  change(changeset, Comeonin.Argon2.add_hash(password))
  end
  defp put_pass_hash(changeset), do: changeset

end

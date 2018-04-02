defmodule Ap.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :hashed_pass, :string

      timestamps()
    end

  end
end

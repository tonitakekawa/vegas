defmodule Ap.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :userId, :string
      add :hashedPassword, :string

      timestamps()
    end

  end
end

defmodule Ap.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :description, :text

      timestamps()
    end

  end
end

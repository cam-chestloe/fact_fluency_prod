defmodule FactFluency.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :username, :string
      add :admin, :boolean

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end

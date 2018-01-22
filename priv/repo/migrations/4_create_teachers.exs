defmodule FactFluency.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :last_name, :string
      add :timestamps, :string

      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :school_id, references(:schools)
      
      timestamps()
    end

    create index(:teachers, [:user_id])
    create index(:teachers, [:school_id])
  end
end

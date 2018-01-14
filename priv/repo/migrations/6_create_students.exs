defmodule FactFluency.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :first_name, :string
      add :last_initial, :string
      add :duplicate_id, :string
      add :timestamps, :string
      add :class_id, references(:classes, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all), null: false 

      timestamps()
    end

    create index(:students, [:class_id])
    create index(:students, [:user_id])
  end
end

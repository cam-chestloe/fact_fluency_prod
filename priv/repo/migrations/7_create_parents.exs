defmodule FactFluency.Repo.Migrations.CreateParents do
  use Ecto.Migration

  def change do
    create table(:parents) do
      add :student_id, references(:students, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create table(:parents_students) do
      add :parent_id, references(:parents)
      add :student_id, references(:students)
      timestamps()
    end

    create index(:parents, [:student_id])
    create index(:parents, [:user_id])
  end
end

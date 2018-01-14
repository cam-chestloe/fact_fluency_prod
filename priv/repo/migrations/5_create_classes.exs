defmodule FactFluency.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
      add :grade, :integer
      add :teacher_id, references(:teachers, on_delete: :nothing)

      timestamps()
    end

    create index(:classes, [:teacher_id])
  end
end

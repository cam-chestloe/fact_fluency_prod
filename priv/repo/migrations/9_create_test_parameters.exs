defmodule FactFluency.Repo.Migrations.CreateTestParameters do
  use Ecto.Migration

  def change do
    create table(:test_parameters) do
      add :test_type, :string
      add :arguments, :map
      add :total_questions, :integer
      add :number_of_random_questions, :integer
      add :include_random_questions_in_score, :boolean, default: false, null: false
      add :time_limit, :integer
      add :warm_up, :boolean, default: false, null: false
      add :timestamps, :string
      add :school_id, references(:schools, on_delete: :delete_all), null: true
      add :teacher_id, references(:teachers, on_delete: :delete_all), null: true 
      add :class_id, references(:classes, on_delete: :delete_all), null: true 
      add :student_id, references(:students, on_delete: :delete_all), null: true
      add :test_id, references(:tests, on_delete: :delete_all), null: true

      timestamps()
    end

    create index(:test_parameters, [:school_id])
    create index(:test_parameters, [:teacher_id])
    create index(:test_parameters, [:class_id])
    create index(:test_parameters, [:student_id])
    create index(:test_parameters, [:test_id])
  end
end

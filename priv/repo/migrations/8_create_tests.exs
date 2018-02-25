defmodule FactFluency.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :review_start_time, :naive_datetime
      add :test_type, :string
      add :timestamps, :string
      add :questions, {:array, :map}, default: []
      add :student_id, references(:students, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tests, [:student_id])
  end
end

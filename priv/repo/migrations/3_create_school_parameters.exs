defmodule FactFluency.Repo.Migrations.CreateSchoolParameters do
  use Ecto.Migration

  def change do
    create table(:school_parameters) do
      add :teachers_can_edit_test_parameters, :boolean, default: false, null: false
      add :teachers_can_edit_warmup_parameters, :boolean, default: false, null: false
      add :school_id, references(:schools, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:school_parameters, [:school_id])
  end
end

defmodule FactFluency.Testing.Question do
    use Ecto.Schema
    import Ecto.Changeset
    alias FactFluency.Testing.Question
  
    @moduledoc """
    Contains all functions needed to create, parse, and answer questions.
  
    Question implements the Ecto.Type behavior.
    """
    embedded_schema do
      field :question, :string
      field :student_answer, :string
      field :correct_answer, :string
      field :start_time, :naive_datetime
      field :end_time, :naive_datetime
      field :start_review_time, :naive_datetime
      field :end_review_time, :naive_datetime
  
      timestamps()
    end
  
    @doc false
    def changeset(%Question{} = question, attrs) do
      question
      |> cast(attrs, [:question, :student_answer, :correct_answer, :start_time, :end_time, :start_review_time, :end_review_time])
      |> validate_required([:question, :student_answer, :correct_answer, :start_time, :end_time, :start_review_time, :end_review_time])
    end
  end
defmodule FactFluency.StudentsTest do
  use FactFluency.DataCase

  alias FactFluency.Students

  describe "students" do
    alias FactFluency.Students.Student

    @valid_attrs %{duplicate_id: "some duplicate_id", first_name: "some first_name", last_initial: "some last_initial", timestamps: "some timestamps"}
    @update_attrs %{duplicate_id: "some updated duplicate_id", first_name: "some updated first_name", last_initial: "some updated last_initial", timestamps: "some updated timestamps"}
    @invalid_attrs %{duplicate_id: nil, first_name: nil, last_initial: nil, timestamps: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Students.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Students.create_student(@valid_attrs)
      assert student.duplicate_id == "some duplicate_id"
      assert student.first_name == "some first_name"
      assert student.last_initial == "some last_initial"
      assert student.timestamps == "some timestamps"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, student} = Students.update_student(student, @update_attrs)
      assert %Student{} = student
      assert student.duplicate_id == "some updated duplicate_id"
      assert student.first_name == "some updated first_name"
      assert student.last_initial == "some updated last_initial"
      assert student.timestamps == "some updated timestamps"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end

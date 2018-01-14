defmodule FactFluency.InstitutionTest do
  use FactFluency.DataCase

  alias FactFluency.Institution

  describe "schools" do
    alias FactFluency.Institution.School

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def school_fixture(attrs \\ %{}) do
      {:ok, school} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Institution.create_school()

      school
    end

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Institution.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Institution.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      assert {:ok, %School{} = school} = Institution.create_school(@valid_attrs)
      assert school.name == "some name"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Institution.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      assert {:ok, school} = Institution.update_school(school, @update_attrs)
      assert %School{} = school
      assert school.name == "some updated name"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Institution.update_school(school, @invalid_attrs)
      assert school == Institution.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Institution.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Institution.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Institution.change_school(school)
    end
  end

  describe "classes" do
    alias FactFluency.Institution.Class

    @valid_attrs %{grade: 42, name: "some name"}
    @update_attrs %{grade: 43, name: "some updated name"}
    @invalid_attrs %{grade: nil, name: nil}

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Institution.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert Institution.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert Institution.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = Institution.create_class(@valid_attrs)
      assert class.grade == 42
      assert class.name == "some name"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Institution.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, class} = Institution.update_class(class, @update_attrs)
      assert %Class{} = class
      assert class.grade == 43
      assert class.name == "some updated name"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Institution.update_class(class, @invalid_attrs)
      assert class == Institution.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = Institution.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Institution.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = Institution.change_class(class)
    end
  end

  describe "school_parameters" do
    alias FactFluency.Institution.SchoolParameters

    @valid_attrs %{teachers_can_edit_test_parameters: true, teachers_can_edit_warmup_parameters: true}
    @update_attrs %{teachers_can_edit_test_parameters: false, teachers_can_edit_warmup_parameters: false}
    @invalid_attrs %{teachers_can_edit_test_parameters: nil, teachers_can_edit_warmup_parameters: nil}

    def school_parameters_fixture(attrs \\ %{}) do
      {:ok, school_parameters} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Institution.create_school_parameters()

      school_parameters
    end

    test "list_school_parameters/0 returns all school_parameters" do
      school_parameters = school_parameters_fixture()
      assert Institution.list_school_parameters() == [school_parameters]
    end

    test "get_school_parameters!/1 returns the school_parameters with given id" do
      school_parameters = school_parameters_fixture()
      assert Institution.get_school_parameters!(school_parameters.id) == school_parameters
    end

    test "create_school_parameters/1 with valid data creates a school_parameters" do
      assert {:ok, %SchoolParameters{} = school_parameters} = Institution.create_school_parameters(@valid_attrs)
      assert school_parameters.teachers_can_edit_test_parameters == true
      assert school_parameters.teachers_can_edit_warmup_parameters == true
    end

    test "create_school_parameters/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Institution.create_school_parameters(@invalid_attrs)
    end

    test "update_school_parameters/2 with valid data updates the school_parameters" do
      school_parameters = school_parameters_fixture()
      assert {:ok, school_parameters} = Institution.update_school_parameters(school_parameters, @update_attrs)
      assert %SchoolParameters{} = school_parameters
      assert school_parameters.teachers_can_edit_test_parameters == false
      assert school_parameters.teachers_can_edit_warmup_parameters == false
    end

    test "update_school_parameters/2 with invalid data returns error changeset" do
      school_parameters = school_parameters_fixture()
      assert {:error, %Ecto.Changeset{}} = Institution.update_school_parameters(school_parameters, @invalid_attrs)
      assert school_parameters == Institution.get_school_parameters!(school_parameters.id)
    end

    test "delete_school_parameters/1 deletes the school_parameters" do
      school_parameters = school_parameters_fixture()
      assert {:ok, %SchoolParameters{}} = Institution.delete_school_parameters(school_parameters)
      assert_raise Ecto.NoResultsError, fn -> Institution.get_school_parameters!(school_parameters.id) end
    end

    test "change_school_parameters/1 returns a school_parameters changeset" do
      school_parameters = school_parameters_fixture()
      assert %Ecto.Changeset{} = Institution.change_school_parameters(school_parameters)
    end
  end
end

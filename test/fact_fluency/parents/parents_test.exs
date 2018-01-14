defmodule FactFluency.ParentsTest do
  use FactFluency.DataCase

  alias FactFluency.Parents

  describe "parents" do
    alias FactFluency.Parents.Parent

    @valid_attrs %{email: "some email", first_name: "some first_name"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name"}
    @invalid_attrs %{email: nil, first_name: nil}

    def parent_fixture(attrs \\ %{}) do
      {:ok, parent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parents.create_parent()

      parent
    end

    test "list_parents/0 returns all parents" do
      parent = parent_fixture()
      assert Parents.list_parents() == [parent]
    end

    test "get_parent!/1 returns the parent with given id" do
      parent = parent_fixture()
      assert Parents.get_parent!(parent.id) == parent
    end

    test "create_parent/1 with valid data creates a parent" do
      assert {:ok, %Parent{} = parent} = Parents.create_parent(@valid_attrs)
      assert parent.email == "some email"
      assert parent.first_name == "some first_name"
    end

    test "create_parent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parents.create_parent(@invalid_attrs)
    end

    test "update_parent/2 with valid data updates the parent" do
      parent = parent_fixture()
      assert {:ok, parent} = Parents.update_parent(parent, @update_attrs)
      assert %Parent{} = parent
      assert parent.email == "some updated email"
      assert parent.first_name == "some updated first_name"
    end

    test "update_parent/2 with invalid data returns error changeset" do
      parent = parent_fixture()
      assert {:error, %Ecto.Changeset{}} = Parents.update_parent(parent, @invalid_attrs)
      assert parent == Parents.get_parent!(parent.id)
    end

    test "delete_parent/1 deletes the parent" do
      parent = parent_fixture()
      assert {:ok, %Parent{}} = Parents.delete_parent(parent)
      assert_raise Ecto.NoResultsError, fn -> Parents.get_parent!(parent.id) end
    end

    test "change_parent/1 returns a parent changeset" do
      parent = parent_fixture()
      assert %Ecto.Changeset{} = Parents.change_parent(parent)
    end
  end
end

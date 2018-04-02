defmodule Ap.UserTest do
  use Ap.ModelCase

  alias Ap.User

  @valid_attrs %{hashedPassword: "some content", userId: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
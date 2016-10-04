defmodule ShoutApi.ShoutTest do
  use ShoutApi.ModelCase

  alias ShoutApi.Shout

  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Shout.changeset(%Shout{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Shout.changeset(%Shout{}, @invalid_attrs)
    refute changeset.valid?
  end
end

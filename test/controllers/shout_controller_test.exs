defmodule ShoutApi.ShoutControllerTest do
  use ShoutApi.ConnCase

  alias ShoutApi.Shout
  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, shout_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    shout = Repo.insert! %Shout{}
    conn = get conn, shout_path(conn, :show, shout)
    assert json_response(conn, 200)["data"] == %{"id" => shout.id,
      "text" => shout.text}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, shout_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, shout_path(conn, :create), shout: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Shout, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, shout_path(conn, :create), shout: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    shout = Repo.insert! %Shout{}
    conn = put conn, shout_path(conn, :update, shout), shout: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Shout, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shout = Repo.insert! %Shout{}
    conn = put conn, shout_path(conn, :update, shout), shout: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    shout = Repo.insert! %Shout{}
    conn = delete conn, shout_path(conn, :delete, shout)
    assert response(conn, 204)
    refute Repo.get(Shout, shout.id)
  end
end

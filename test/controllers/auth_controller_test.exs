defmodule ShoutApi.AuthControllerTest do
  use ShoutApi.ConnCase

  alias ShoutApi.User
  
  setup do
    {:ok, conn: put_req_header(build_conn(), "accept", "application/json")}
  end

  describe "POST signup/2" do
    test "returns 200 for correct params", %{conn: conn} do
      params = %{"user" => %{"username" => "testguy", "email" => "testguy@test.com", "password" => "password", "password_confirmation" => "password"}}
      conn = conn |> post(auth_path(conn, :sign_up, params))
      assert json_response(conn, 200)
    end
    test "returns 422 and errors for incorrect params", %{conn: conn} do
      params = %{"user" => %{"username" => "testguy", "email" => "testguy@test.com", "password" => "password", "password_confirmation" => ""}}
      conn = conn |> post(auth_path(conn, :sign_up, params))
      response = json_response(conn, 422)
      assert response["errors"] == %{"password_confirmation" => ["does not match confirmation", "can't be blank"]}
    end
  end

  describe "POST login/2" do
    test "returns 200 for correct params", %{conn: conn} do
      changeset = User.changeset(%User{}, %{"username" => "testguy", "email" => "testguy@test.com", "password" => "password", "password_confirmation" => "password"})
      user = Repo.insert(changeset)
      conn = conn |> post(auth_path(conn, :login, %{"user" => %{ "email" => "testguy@test.com", "password" => "password"}}))
      assert json_response(conn, 200)
    end
    test "returns 401 with incorrect params", %{conn: conn} do
      conn = conn |> post(auth_path(conn, :login, %{"user" => %{ "email" => "testguy@test.com", "password" => "testpass"}}))
      response = json_response(conn, 401)
      assert response["message"] == "Could not login"
    end
  end

  test "GET logout" do
    # conn = get conn(), "/logout"
    # "with jwt header"
    # "without jwt header"
  end
end
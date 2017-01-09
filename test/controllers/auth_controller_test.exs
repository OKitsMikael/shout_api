defmodule ShoutApi.AuthControllerTest do
  use ShoutApi.ConnCase

  setup do
    {:ok, conn: put_req_header(build_conn, "accept", "application/json")}
  end

  describe "POST /signup" do
    test "returns JSON for correct params", %{conn: conn} do
      params = %{"user" => %{"email" => "testguy@test.com", "password" => "password", "password_confirmation" => "password"}}
      conn = build_conn(:post, "/signup", params)
      post conn, "/signup"
      assert json_response(conn, 200)
    end
    test "renders errors for incorrect params" do
      params = %{"user" => %{"email" => "testguy@test.com", "password" => "password", "password_confirmation" => ""}}
      conn = build_conn(:post, "/signup", params)
      post conn, "/signup"
      assert json_response(conn, 422)
    end
  end

  @tag :pending
  test "POST /login" do
    # conn = post conn(), "/post"
    # "with correct params"
    # "with incorrect params"
  end

  @tag :pending
  test "GET logout" do
    # conn = get conn(), "/logout"
    # "with jwt header"
    # "without jwt header"
  end
end
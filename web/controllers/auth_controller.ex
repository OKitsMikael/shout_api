defmodule ShoutApi.AuthController do
  use ShoutApi.Web, :controller

  alias ShoutApi.User

  def sign_up(conn, %{"user" => user_params}) do
    case Repo.insert(User.changeset(%User{}, user_params)) do
      {:ok, user} ->
         new_conn = Guardian.Plug.api_sign_in(conn, user)
         jwt = Guardian.Plug.current_token(new_conn)
         {:ok, claims} = Guardian.Plug.claims(new_conn)
         exp = 
          claims
          |> Map.get("exp")
          |> Integer.to_string()

         new_conn
         |> put_resp_header("authorization", "Bearer #{jwt}")
         |> put_resp_header("x-expires", exp)
         |> render("login.json", user: user, jwt: jwt, exp: exp)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ShoutApi.ChangesetView, "error.json", changeset: changeset)
    end
  end
  def sign_up(conn, _params) do
    render(conn, "error.json")
  end

  def login(conn, params) do
    case User.find_and_confirm_password(params) do
      {:ok, user} ->
         new_conn = Guardian.Plug.api_sign_in(conn, user)
         jwt = Guardian.Plug.current_token(new_conn)
         {:ok, claims} = Guardian.Plug.claims(new_conn)
         exp = 
          claims
          |> Map.get("exp")
          |> Integer.to_string()

         new_conn
         |> put_resp_header("authorization", "Bearer #{jwt}")
         |> put_resp_header("x-expires", exp)
         |> render("login.json", user: user, jwt: jwt, exp: exp)
      {:error, _changeset} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end

  def logout(conn, _params) do
    jwt = Guardian.Plug.current_token(conn)
    {:ok, claims} = Guardian.Plug.claims(conn)
    Guardian.revoke!(jwt, claims)
    render(conn, "logout.json")
  end
  def logout(conn, _), do: render("error.json", message: "Error logging out, check jwt and claims")
end
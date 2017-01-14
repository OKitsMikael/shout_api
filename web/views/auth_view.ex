defmodule ShoutApi.AuthView do
  use ShoutApi.Web, :view

  def render("login.json", %{user: user, jwt: jwt, exp: exp}) do
    %{
      data: %{
        user: render_one(user, ShoutApi.AuthView, "user.json", as: :user),
        jwt: jwt,
        exp: exp
      }
    }
  end

  def render("logout.json", _assigns) do
    %{data: %{message: "Successfully logged out"}}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username, email: user.email}
  end
end
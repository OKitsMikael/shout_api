defmodule ShoutApi.Factory do
  use ExMachina.Ecto, repo: ShoutApi.Repo

  alias ShoutApi.User

  def user_factory do
    %User{
      username: "testguy",
      email: "testguy@test.com"
    }
  end
end
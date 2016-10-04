defmodule ShoutApi.ShoutView do
  use ShoutApi.Web, :view

  def render("index.json", %{shouts: shouts}) do
    %{data: render_many(shouts, ShoutApi.ShoutView, "shout.json")}
  end

  def render("show.json", %{shout: shout}) do
    %{data: render_one(shout, ShoutApi.ShoutView, "shout.json")}
  end

  def render("shout.json", %{shout: shout}) do
    %{id: shout.id,
      text: shout.text}
  end
end

defmodule ShoutApi.ShoutController do
  use ShoutApi.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  alias ShoutApi.Shout

  # def index(conn, _params) do
  #   shouts = Repo.all(Shout)
  #   render(conn, "index.json", shouts: shouts)
  # end

  def create(conn, %{"shout" => shout_params}) do
    changeset = Shout.changeset(%Shout{}, shout_params)

    case Repo.insert(changeset) do
      {:ok, shout} ->
        conn
        |> put_status(:created)
        # |> put_resp_header("location", shout_path(conn, :show, shout))
        |> render("show.json", shout: shout)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ShoutApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shout = Repo.get!(Shout, id)
    render(conn, "show.json", shout: shout)
  end

  def update(conn, %{"id" => id, "shout" => shout_params}) do
    shout = Repo.get!(Shout, id)
    changeset = Shout.changeset(shout, shout_params)

    case Repo.update(changeset) do
      {:ok, shout} ->
        render(conn, "show.json", shout: shout)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ShoutApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shout = Repo.get!(Shout, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shout)

    send_resp(conn, :no_content, "")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render("error.json", message: "Authentication required")
  end
end

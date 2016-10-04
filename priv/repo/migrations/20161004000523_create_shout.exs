defmodule ShoutApi.Repo.Migrations.CreateShout do
  use Ecto.Migration

  def change do
    create table(:shouts) do
      add :text, :string

      timestamps()
    end

  end
end

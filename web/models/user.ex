defmodule ShoutApi.User do
  use ShoutApi.Web, :model

  alias Comeonin.Bcrypt
  alias ShoutApi.User
  alias ShoutApi.Repo

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :password, :password_confirmation])
    |> validate_required([:email, :username, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_password()
    |> unique_constraint(:email)
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
    hashed_password =
      changeset
      |> get_field(:password)
      |> Bcrypt.hashpwsalt()

    changeset
    |> put_change(:password_hash, hashed_password)
  end

  def find_and_confirm_password(%{"password" => password, "email" => email}) do
    verify_credentials(email, password)
  end

  defp verify_credentials(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- find_by_email(email),
      do: verify_password(password, user)
  end

  defp find_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, "User with email '#{email}' not found"}
      user ->
        {:ok, user}
    end

  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if Bcrypt.checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
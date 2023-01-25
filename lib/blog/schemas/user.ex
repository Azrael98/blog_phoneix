defmodule Blog.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    has_many :posts, Blog.Schemas.Post
    has_many :comments, Blog.Schemas.Comment

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username])
    |> validate_required([:username])
  end
end

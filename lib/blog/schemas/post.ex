defmodule Blog.Schemas.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :post_text, :string

    has_many :comments, Blog.Schemas.Comment
    belongs_to :user, Blog.Schemas.User

    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:post_text])
    |> validate_required([:post_text])
  end
end

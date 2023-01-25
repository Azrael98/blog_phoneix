defmodule Blog.App do
  alias Blog.Schemas.{User, Post, Comment}
  alias Blog.Repo
  alias Ecto.Changeset
  import Ecto.Query

  def list_posts() do
    IO.puts("list_posts called")

    query =
      from p in Post,
        order_by: [desc: p.id],
        preload: :user

    Repo.all(query)
  end

  def single(id) do
    Repo.get(Post, id) |> Repo.preload([:comments])
  end

  def user(id) do
    Repo.get(User, id)
  end

  def save(id, data) do
    user = Repo.get(User, id)
    comment = data["comment"]
    insertData = data["post_text"]
    IO.puts(comment)
    post = Repo.insert(%Post{post_text: insertData, user: user})
    Repo.insert(%Comment{comment_text: comment, post: post, user: user})
  end

  def savecomment(comment, post, user) do
    saved = Repo.insert(%Comment{comment_text: comment, post: post, user: user})
  end
end

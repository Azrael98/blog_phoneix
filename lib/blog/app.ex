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

  def save(id, post) do
    user = Repo.get(User, id)
    text = post["post_text"]
    title = post["post_title"]
    Repo.insert(%Post{post_title: title, post_text: text, user: user})
  end

  def savecomment(comment, post, user) do
    Repo.insert(%Comment{comment_text: comment, post: post, user: user})
  end

  def delete_post(id) do
    Post
    |> Repo.get(id)
    |> Repo.delete()
  end

  def update_post(id, title, text) do
    post = Repo.get!(Post, id)
    post = Ecto.Changeset.change(post, post_title: title, post_text: text)
    Repo.update(post)
  end
end



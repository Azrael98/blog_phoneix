defmodule BlogWeb.BlogsController do
  use BlogWeb, :controller

  alias Blog.App
  alias Blog.Schemas.Post
  alias Blog.Schemas.Comment

  def index(conn, _params) do
    posts = App.list_posts()
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "index.html", posts: posts, changeset: changeset)
  end

  def single(conn, %{"id" => id}) do
    post = App.single(id)
    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "single.html", post: post, changeset: changeset, id: id)
  end

  def write(conn, _params) do
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "create.html", changeset: changeset)
  end

  def save(conn, %{"post" => post}) do
    # IO.puts(conn)
    # IO.puts(params)

    # render(conn, "check.html", check: check)
    # IO.inspect(post)
    App.save(1, post)
    redirect(conn, to: "/blogs")
  end

  def savecomment(conn, params) do
    data = params["comment"]

    comment = data["comment_text"]
    id = data["id"]

    IO.puts(id)

    IO.puts(comment)

    post = App.single(id)

    user = App.user(1)

    saved = App.savecomment(comment, post, user)

    changeset = Comment.changeset(%Comment{}, %{})

    redirect(conn, to: "/blogs/#{id}")
    # render(conn, "single.html", post: post, changeset: changeset, id: id)
  end

  def edit(conn, %{"id" => id}) do
    IO.inspect(id)
    post = App.single(id)
    IO.inspect(post)
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "update.html", id: id, post: post, changeset: changeset)
  end

  def update(conn, %{"post" => %{"id" => id, "text" => text, "title" => title}}) do
    App.update_post(id, title, text)
    redirect(conn, to: "/blogs")
  end

  def delete_post(conn, %{"id" => id}) do
    App.delete_post(id)
    redirect(conn, to: "/blogs")
  end

  def delete_comment(conn, %{"id" => id}) do
    post = App.delete_comment(id)
    {:ok, post} = post
    post_id = post.post_id
    redirect(conn, to: "/blogs/#{post_id}")
    # render(conn, "check.html", id: id)
  end
end

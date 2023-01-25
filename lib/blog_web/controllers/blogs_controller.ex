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
end

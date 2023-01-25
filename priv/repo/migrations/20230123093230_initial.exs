defmodule Blog.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table ("users") do
      add :username, :string

      timestamps()
    end

    create table ("posts") do
      add :user_id, references (:users)
      add :post_text, :text

      timestamps()
    end

    create table ("comments") do
      add :user_id, references (:users)
      add :post_id, references (:posts)
      add :comment_text, :text

      timestamps()
    end
  end
end

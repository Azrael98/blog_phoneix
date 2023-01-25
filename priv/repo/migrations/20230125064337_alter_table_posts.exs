defmodule Blog.Repo.Migrations.AlterTablePosts do
  use Ecto.Migration

  def change do
    alter table ("posts") do
      add :post_title, :text
    end
  end
end

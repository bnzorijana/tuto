defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :team, references(:teams, on_delete: :nothing)
      add :role, :integer, default: 1
      add :graph_type, :string, default: "pie"
      add :color_1, :string, default: "blue"
      add :color_2, :string, default: "red"
      timestamps()
    end
    create unique_index(:users, :username)
    create unique_index(:users, :email)
    create index(:users, [:team])
  end
end

defmodule TimeManager.Task.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, null: false
    field :username, :string, null: false
    field :team, :id
    field :role, :integer, null: false, default: 1
    field :graph_type, :string , null: false, default: "pie"
    field :color_1, :string, null: false, default: "blue"
    field :color_2, :string, null: false, default: "red"
    has_many :workingtimes, TimeManager.Task.Workingtime
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :team, :graph_type, :color_1, :color_2])
    |> validate_required([:username, :email, :role, :graph_type, :color_1, :color_2])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/\S+@\S+\.\S+/)
  end
end

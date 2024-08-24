defmodule SimplePhoenixTodo.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :status, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    attrs = Map.put_new(attrs, "status", "Not Done")

    todo
    |> cast(attrs, [:title, :status, :status])
    |> validate_required([:title, :status, :status])
    |> validate_inclusion(:status, ["Done", "Not Done"])
    |> validate_length(:title, min: 3)
  end
end

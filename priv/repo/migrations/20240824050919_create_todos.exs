defmodule SimplePhoenixTodo.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end

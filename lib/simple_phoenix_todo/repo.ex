defmodule SimplePhoenixTodo.Repo do
  use Ecto.Repo,
    otp_app: :simple_phoenix_todo,
    adapter: Ecto.Adapters.SQLite3
end

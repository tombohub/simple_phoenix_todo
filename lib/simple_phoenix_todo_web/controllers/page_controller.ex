import Ecto.Query
alias SimplePhoenixTodo.{Repo, Todo}

defmodule SimplePhoenixTodoWeb.PageController do
  alias Phoenix.Router.Route
  use SimplePhoenixTodoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    changeset = Todo.changeset(%Todo{}, %{})
    todos = Repo.all(Todo)

    render(conn, :home, layout: false, changeset: changeset, todos: todos)
  end

  def delete(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)

    case Repo.delete(todo) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Todo deleted successfully.")
        |> redirect(to: ~p"/")

      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Failed to delete todo.")
        |> redirect(to: ~p"/")
    end
  end

  def toggle_status(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)

    new_status =
      case todo.status do
        "Done" -> "Not Done"
        "Not Done" -> "Done"
        _ -> "Not Done"
      end

    changeset = Todo.changeset(todo, %{"status" => new_status})

    case Repo.update(changeset) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Todo status updated successfully.")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:info, "Failed to update todo status.")
        |> redirect(to: ~p"/")
    end
  end

  def create(conn, %{"todo" => todo_params}) do
    changeset = Todo.changeset(%Todo{}, todo_params)
    todos = Repo.all(Todo)

    case Repo.insert(changeset) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Todo created success")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(
          :info,
          "Failed to create todo"
        )
        |> render(:home, layout: false, changeset: changeset, todos: todos)
    end
  end
end

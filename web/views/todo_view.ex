defmodule Ap.TodoView do
  use Ap.Web, :view

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, Ap.TodoView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, Ap.TodoView, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      title: todo.title,
      completed: todo.completed}
  end
end

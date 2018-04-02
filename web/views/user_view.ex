defmodule Ap.UserView do
  use Ap.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Ap.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Ap.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      userId: user.userId,
      hashedPassword: user.hashedPassword}
  end
end

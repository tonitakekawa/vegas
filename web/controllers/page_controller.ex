defmodule Ap.PageController do
  use Ap.Web, :controller

  def index(conn, _params) do
    session = get_session(conn, :count) || 0
    conn    = put_session(conn, :count, session + 1)
    render conn, "index.html", session: get_session(conn, :count)
    #render conn, "index.html"
  end

end

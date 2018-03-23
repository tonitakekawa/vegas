


# Elixir HTTP json test
#



defmodule Ap.PageControllerTest do
  use Ap.ConnCase

  test "GET /", %{conn: conn} do
    conn   = get conn, "http://localhost:4000/?a=b"
    result = html_response(conn, 200)
    IO.inspect result
    assert result == %{"params" => %{"a" => "b"}}
  end
end

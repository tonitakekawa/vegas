
defmodule Ap.ApiController do
  use Ap.Web, :controller

  # 処理を一般化すると
  # 1. session => s1
  # 2. s2 = function(s1)
  # 3. s2 => session

  defp ssn(conn, default_state \\ :no_session) do
    s = get_session(conn, :cointoss_s) || default_state
    c = get_session(conn, :cointoss_c) || 0
    h = get_session(conn, :cointoss_h) || 0
    w = get_session(conn, :cointoss_w) || 0

    { s, c, h, w }
  end

  defp upd(conn, s, c, h, w) do
    conn
    |> put_session(:cointoss_s, s)
    |> put_session(:cointoss_c, c)
    |> put_session(:cointoss_h, h)
    |> put_session(:cointoss_w, w)
  end

  # -- todo 一関数で行ける
  # message
  # |> get session
  # |> state guard
  # |> state filter
  # |> put session
  # |> connection update
  # |> return json

  def init(conn, _params) do

    IO.inspect conn

    # get session
    {_s, c, h, w} = ssn(conn, :wait)

    # state guard

    #fn a = () -> 1 end

    # 掛けコインがあれば戻しておく
    c = c + h
    h = 0

    # 勝ちコインがあれば清算しておく
    c = c + w
    w = 0

    # state filter
    if 0 >= c do
      c = 3
    end

    # 強制的に wait に遷移
    s = :wait

    # conn update
    upd_conn = upd(conn, s, c, h, w)

    # return json
    json upd_conn, format(s, c, h, w, "INIT")
  end

  def bet(conn, _params) do

    # get session
    {s, c, h, w} = ssn(conn)

    # state guard
    guard = case s do
      :no_session -> "error"
      :wait       -> "ok"
      :bet        -> "error"
      :result     -> "ok"
    end

    # state filter
    {s, c, h, w} = case w do
      0 -> { :bet, c-1, 1, 0 }    # ダブルアップでないのでコイン減算
      _ -> { :bet, c  , w, 0 }    # ダブルアップ
    end

    # conn update
    upd_conn = upd(conn, s, c, h, w)

    # return json
    json upd_conn, format(s, c, h, w, "BET")
  end

  def game(conn, _params) do

    {s, c, h, w} = ssn(conn)

    # TODO 状態ガード

    # 0 : 負け
    # 1 : 勝ち
    r = Enum.random(0..1)

    {s, c, h, w, msg} = case r do
      0 -> { :wait  , c, 0,     0, "lose" } # 負け
      1 -> { :result, c, 0, h * 2, "win"  } # 勝ち
    end

    upd_conn = upd(conn, s, c, h, w)

    json upd_conn, format(s, c, h, w, "GAME")
  end

  defp format(s, c, h, w, r) do
    %{state: s, coin: c, hand: h, win: w, request: r}
  end

end

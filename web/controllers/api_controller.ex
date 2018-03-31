defmodule Ap.ApiController do
  use Ap.Web, :controller

  defp get_state(conn) do
    s = get_session(conn, :cointoss_s) || :no_session
    c = get_session(conn, :cointoss_c) || 0
    h = get_session(conn, :cointoss_h) || 0
    w = get_session(conn, :cointoss_w) || 0

    %{ conn: conn, state: s, coin: c, hand: h, win: w }
  end

  defp update_state(s) do
    conn = s.conn
    |> put_session(:cointoss_s, s.state)
    |> put_session(:cointoss_c, s.coin)
    |> put_session(:cointoss_h, s.hand)
    |> put_session(:cointoss_w, s.win)

    %{
      conn: conn,
      state: s.state,
      coin: s.coin,
      hand: s.hand,
      win: s.win
    }
  end

  defp format(s, r) do
    m = %{
      state: s.state,
      coin:  s.coin,
      hand:  s.hand,
      win:     s.win,
      request: r
    }

    %{conn: s.conn, map: m}
  end

  defp init_state_filter(s) do
    c1 = s.coin + s.hand + s.win
    c2 = case c1 do
      0 -> 3
      _ -> c1
    end

    %{
      conn:  s.conn,
      state: :wait,
      coin:  c2,
      hand:  0,
      win:   0
    }
  end

  defp bet_state_filter(s) do
    bet_state_filter(s.state, s)
  end

  defp bet_state_filter(:bet, s) do
    %{
      conn:  s.conn,
      state: :error,
      coin:  0,
      hand:  0,
      win:   0
    }
  end

  defp bet_state_filter(_, s) do

    {coin, hand} = case s.win do
      0 -> { s.coin-1, 1      }    # ダブルアップでないのでコイン減算
      _ -> { s.coin  , s.win  }    # ダブルアップ
    end

    %{
      conn:  s.conn,
      state: :bet,
      coin:  coin,
      hand:  hand,
      win:   0
    }
  end

  defp game_state_filter(s) do
    game_state_filter(s.state, s)
  end

  defp game_state_filter(:bet, s) do

    # 0 : 負け  1 : 勝ち
    result = Enum.random(0..1)

    {state, win} = case result do
      0 -> { :wait  ,          0 } # 負け
      1 -> { :result, s.hand * 2 } # 勝ち
    end

    %{
      conn:  s.conn,
      state: state,
      coin:  s.coin,
      hand:  0,
      win:   win
    }
  end

  defp game_state_filter(_, s) do
    %{
      conn:  s.conn,
      state: :error,
      coin:  0,
      hand:  0,
      win:   0
    }
  end

  def version(conn, _param) do
    json conn, %{version: "0.0.0"}
  end

  def init(conn, _params) do
    s = get_state(conn)
    |> init_state_filter
    |> update_state
    |> format("INIT")

    json s.conn, s.map
  end

  def bet(conn, _params) do
    s = get_state(conn)
    |> bet_state_filter
    |> update_state
    |> format("BET")

    json s.conn, s.map
  end

  def game(conn, _params) do
    s = get_state(conn)
    |> game_state_filter
    |> update_state
    |> format("GAME")

    json s.conn, s.map
  end

end

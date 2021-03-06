defmodule Ap.Router do
  use Ap.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session

    # クロススクリプトの許容はリバースプロキシで解決する
    #plug CORSPlug, [origin: "http://192.168.3.2"]
    #plug CORSPlug, [origin: "http://192.168.3.2:4000"]
    plug CORSPlug, [origin: "http://localhost:8000"]
  end


  scope "/users", Ap do
    pipe_through :api
    resources "/", UserController
    options "/", UserController, :options # 追加
    #resources "/", UserController, except: [:new, :edit]
  end

  scope "/cointoss", Ap do
    pipe_through :api
    #pipe_through :browser

    post      "/init"     , ApiController  , :init
    post      "/bet"      , ApiController  , :bet
    post      "/game"     , ApiController  , :game
    get       "/version"  , ApiController  , :version
    resources "/todos"    , TodoController

    options "/init", ApiController, :options # 追加
    options "/bet", ApiController, :options # 追加
    options "/game", ApiController, :options # 追加
    options "/version", ApiController, :options # 追加
    options "/todos", ApiController, :options # 追加
  end

end

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

    #plug CORSPlug, [origin: "http://192.168.3.2"]
    #plug CORSPlug, [origin: "http://192.168.3.2:4000"]
    #plug CORSPlug, [origin: "http://localhost:9999"]
  end

  scope "/", Ap do
    pipe_through :api
    #pipe_through :browser

    get       "/"                , PageController, :index   # browser用に残す
    post      "/cointoss/init"   , ApiController , :init
    post      "/cointoss/bet"    , ApiController,  :bet
    post      "/cointoss/game"   , ApiController,  :game

    resources "/todos"           , TodoController

  end

end

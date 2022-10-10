defmodule MswWeb.Router do
  use MswWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MswWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", MswWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/episodes", EpisodesLive
  end
end

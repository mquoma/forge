defmodule ForgeWeb.Router do
  use ForgeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ForgeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ForgeWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ForgeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ForgeWeb.Telemetry

      scope "/", ForgeWeb do
        live "/customers", CustomerLive.Index, :index
        live "/customers/new", CustomerLive.Index, :new
        live "/customers/:id/edit", CustomerLive.Index, :edit

        live "/customers/:id", CustomerLive.Show, :show
        live "/customers/:id/show/edit", CustomerLive.Show, :edit

        live "/vendors", VendorLive.Index, :index
        live "/vendors/new", VendorLive.Index, :new
        live "/vendors/:id/edit", VendorLive.Index, :edit

        live "/vendors/:id", VendorLive.Show, :show
        live "/vendors/:id/show/edit", VendorLive.Show, :edit
      end

    end
  end
end

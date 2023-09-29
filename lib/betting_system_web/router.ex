defmodule BettingSystemWeb.Router do
  use BettingSystemWeb, :router

  import BettingSystemWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BettingSystemWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BettingSystemWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BettingSystemWeb do
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
      live_dashboard "/dashboard", metrics: BettingSystemWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", BettingSystemWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create

    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", BettingSystemWeb do
    pipe_through [:browser, :require_authenticated_admin]

    live "/sports", SportLive.Index, :index
    live "/simulate", SimulategamesLive.Index, :index

    live "/sports/new", SportLive.Index, :new
    live "/sports/:id/edit", SportLive.Index, :edit

    # live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit
    live "/us/:id", UserLive.Show, :show

    live "/sports/:id", SportLive.Show, :show
    live "/sports/:id/show/edit", SportLive.Show, :edit
    # live "/games", GameLive.Index, :index
    live "/games/new", GameLive.Index, :new
    live "/games/:id/edit", GameLive.Index, :edit

    live "/games/:id", GameLive.Show, :show
    live "/games/:id/show/edit", GameLive.Show, :edit

    live "/bets", BetsLive.Index, :index
    live "/bets/new", BetsLive.Index, :new
    live "/bets/:id/edit", BetsLive.Index, :edit

    live "/bets/:id", BetsLive.Show, :show
    live "/bets/:id/show/edit", BetsLive.Show, :edit
    live "/betslips", BetslipLive.Index, :index
    live "/betslips/new", BetslipLive.Index, :new
    live "/betslips/:id/edit", BetslipLive.Index, :edit

    live "/betslips/:id", BetslipLive.Show, :show
    live "/betslips/:id/show/edit", BetslipLive.Show, :edit

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", BettingSystemWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/users", UserLive.Index, :index
    live "/games", GameLive.Index, :index
  end

  scope "/", BettingSystemWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end

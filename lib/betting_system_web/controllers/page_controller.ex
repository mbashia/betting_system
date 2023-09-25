defmodule BettingSystemWeb.PageController do
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule MagicCommanderWeb.DefaultController do
  use MagicCommanderWeb, :controller

  def index(conn, _params) do
    send_resp(conn, :ok, "It's alive! - #{Mix.env()}")
  end
end

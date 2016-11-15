defmodule Charsheet.PageController do
  use Charsheet.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

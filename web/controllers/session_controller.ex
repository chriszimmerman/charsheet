defmodule Charsheet.SessionController do
  use Charsheet.Web, :controller

  alias Charsheet.User
  alias Passport.Session


  def new(conn, _) do
    conn
    |> render(:new)
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Session.login(conn, email, pass) do
    {:ok, conn} ->
      conn
      |> put_flash(:info, "Welcome back!")
      |> redirect(to: character_path(conn, :index))
    {:error, _reason, conn} ->
      conn
      |> put_flash(:error, "Invalid username/password combination")
      |> render(:new)
    end
  end

  def delete(conn, _) do
    conn
    |> Session.logout()
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: page_path(conn, :index))
  end
end

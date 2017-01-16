defmodule Charsheet.PasswordController do
  use Charsheet.Web, :controller

  alias Charsheet.User

  def new(conn, _) do
    conn
    |> render(:new)
  end

  def reset_password(conn, %{"user" => %{"email" => email}}) do
    conn
    |> put_flash(:info, "Password reset link has been sent to your email address.")
    |> redirect(to: session_path(conn, :new))
  end
end

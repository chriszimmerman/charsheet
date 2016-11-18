defmodule Charsheet.CharacterController do
  use Charsheet.Web, :controller

  alias Charsheet.Character

  def index(conn, _params) do
    characters = Repo.all(Character)
    render(conn, "index.html", characters: characters)
  end

  def new(conn, _params) do
    changeset = Character.changeset(%Character{hit_points: 1, level: 1, experience_points: 0, strength: 10, dexterity: 10, constitution: 10, intelligence: 10, wisdom: 10, charisma: 10})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"character" => character_params}) do
    changeset = Character.changeset(%Character{}, character_params)

    case Repo.insert(changeset) do
      {:ok, _character} ->
        conn
        |> put_flash(:info, "Character created successfully.")
        |> redirect(to: character_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Repo.get!(Character, id)
    render(conn, "show.html", character: character)
  end

  def edit(conn, %{"id" => id}) do
    character = Repo.get!(Character, id)
    changeset = Character.changeset(character)
    render(conn, "edit.html", character: character, changeset: changeset)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Repo.get!(Character, id)
    changeset = Character.changeset(character, character_params)

    case Repo.update(changeset) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character updated successfully.")
        |> redirect(to: character_path(conn, :show, character))
      {:error, changeset} ->
        render(conn, "edit.html", character: character, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Repo.get!(Character, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(character)

    conn
    |> put_flash(:info, "#{character.name} deleted successfully.")
    |> redirect(to: character_path(conn, :index))
  end
end

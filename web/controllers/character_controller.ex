defmodule Charsheet.CharacterController do
  use Charsheet.Web, :controller

  alias Charsheet.Character
  alias Charsheet.CoreStats

  def index(conn, _params) do
    if !conn.assigns.current_user do
      redirect(conn, to: session_path(conn, :new))
    else
      characters = Repo.all(Character)
      render(conn, "index.html", characters: characters)
    end
  end

  def new(conn, _params) do
    default_stats = %CoreStats{
      strength: 10,
      dexterity: 10,
      constitution: 10,
      intelligence: 10,
      wisdom: 10,
      charisma: 10
    }
  	stats_changeset = CoreStats.changeset(default_stats)

  	default_character = %Character{
      hit_points: 1,
      level: 1,
      experience_points: 0,
      core_stats: stats_changeset
    }
  	character_changeset = Character.changeset(default_character)

    render(conn, "new.html", changeset: character_changeset)
  end

  def create(conn, %{"character" => character_params}) do
  	stats = CoreStats.changeset(%CoreStats{}, character_params["core_stats"])
    changeset = Character.changeset(%Character{user_id: conn.assigns.current_user.id}, character_params)
    |> Ecto.Changeset.put_embed(:core_stats, stats.changes)

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
    stats = CoreStats.changeset(%CoreStats{}, character_params["core_stats"])
    changeset = Character.changeset(character, character_params)
    |> Ecto.Changeset.put_embed(:core_stats, stats.changes)

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

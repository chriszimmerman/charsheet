defmodule Charsheet.CharacterControllerTest do
  use Charsheet.ConnCase

  alias Charsheet.Character

  @valid_stats %{strength: 10, dexterity: 11, constitution: 12, intelligence: 13, wisdom: 14, charisma: 15}
  @invalid_stats %{strength: -1, dexterity: -1, constitution: -2, intelligence: -3, wisdom: -4, charisma: -5}

  @valid_attrs %{name: "some content", hit_points: 9, level: 1, experience_points: 0}
  @invalid_attrs %{hit_points: 0}

  def get_valid_character do
    Map.merge(@valid_attrs, %{core_stats: @valid_stats})
  end

  def get_invalid_character do
    Map.merge(@invalid_attrs, %{core_stats: @invalid_stats})
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, character_path(conn, :index)
    assert html_response(conn, 200) =~ "Characters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, character_path(conn, :new)
    assert html_response(conn, 200) =~ "New character"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, character_path(conn, :create), character: get_valid_character()
    assert redirected_to(conn) == character_path(conn, :index)
    assert Repo.get_by(Character, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, character_path(conn, :create), character: get_invalid_character()
    assert html_response(conn, 200) =~ "New character"
  end

  test "shows chosen resource", %{conn: conn} do
    character = Repo.insert! Map.merge(%Character{}, get_valid_character())
    conn = get conn, character_path(conn, :show, character)
    assert html_response(conn, 200) =~ "some content"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, character_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    character = Repo.insert! %Character{}
    conn = get conn, character_path(conn, :edit, character)
    assert html_response(conn, 200) =~ "Edit character"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    character = Repo.insert! %Character{}
    conn = put conn, character_path(conn, :update, character), character: get_valid_character()
    assert redirected_to(conn) == character_path(conn, :show, character)
    assert Repo.get_by(Character, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    character = Repo.insert! %Character{}
    conn = put conn, character_path(conn, :update, character), character: get_invalid_character()
    assert html_response(conn, 200) =~ "Edit character"
  end

  test "deletes chosen resource", %{conn: conn} do
    character = Repo.insert! %Character{}
    conn = delete conn, character_path(conn, :delete, character)
    assert redirected_to(conn) == character_path(conn, :index)
    refute Repo.get(Character, character.id)
  end
end

defmodule Naranjo.HistoryControllerTest do
  use Naranjo.ConnCase

  alias Naranjo.History
  @valid_attrs %{schedule: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, history_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing histories"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, history_path(conn, :new)
    assert html_response(conn, 200) =~ "New history"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, history_path(conn, :create), history: @valid_attrs
    assert redirected_to(conn) == history_path(conn, :index)
    assert Repo.get_by(History, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, history_path(conn, :create), history: @invalid_attrs
    assert html_response(conn, 200) =~ "New history"
  end

  test "shows chosen resource", %{conn: conn} do
    history = Repo.insert! %History{}
    conn = get conn, history_path(conn, :show, history)
    assert html_response(conn, 200) =~ "Show history"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, history_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    history = Repo.insert! %History{}
    conn = get conn, history_path(conn, :edit, history)
    assert html_response(conn, 200) =~ "Edit history"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    history = Repo.insert! %History{}
    conn = put conn, history_path(conn, :update, history), history: @valid_attrs
    assert redirected_to(conn) == history_path(conn, :show, history)
    assert Repo.get_by(History, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    history = Repo.insert! %History{}
    conn = put conn, history_path(conn, :update, history), history: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit history"
  end

  test "deletes chosen resource", %{conn: conn} do
    history = Repo.insert! %History{}
    conn = delete conn, history_path(conn, :delete, history)
    assert redirected_to(conn) == history_path(conn, :index)
    refute Repo.get(History, history.id)
  end
end

defmodule Naranjo.PageControllerTest do
  use Naranjo.ConnCase

  def with_valid_authorization_header(conn) do
    conn
    |> put_req_header("authorization", "Basic dXNlcjpzWNyZXQ=")
  end

  def with_invalid_authorization_header(conn) do
    conn
    |> put_req_header("authorization", "Basic I like turtles")
  end

  test "GET / without authorization header should throw 401,", %{conn: conn} do
    conn = get conn, "/"

    assert response(conn, 401) == "unauthorized"
    assert get_resp_header(conn, "www-authenticate") == ["Basic realm=\"Thou Shalt not pass\""
  end

  test "GET / with correct authorization should be OK", %{conn: conn} do
    conn = conn
    |> with_valid_authorization_header()
    |> get("/")
		
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"

  end

  test "GET / with incorrect authorization should throw 401", %{conn: conn} do
    conn = conn
    |> with_invalid_authorization_header()
    |> get("/")

    assert response(conn, 401) == "unauthorized"
    assert get_resp_header(conn, "www-authenticate") == ["Basic realm=\"Thou Shalt not pass\""]		
  end
end

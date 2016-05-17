defmodule Reph.PageController do
  use Reph.Web, :controller

  def index(conn, %{"token" => token}) do
    case Guardian.decode_and_verify(token) do
      { :ok, claims } ->
        Guardian.revoke!(token)
        {:ok, user} = Guardian.serializer.from_token(claims["sub"])
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/app")
      _ ->
        redirect(conn, to: "/")
    end
  end
  def index(conn, %{"path" => path}) do
    connections = Reph.Connections.state()
    path = "/" <> Enum.join(path, "/")
    props = %{
      "location" => path,
      "initial_state" => %{"connections" => connections}
    }

    props_client = %{"connections" => connections}
    %{"html" => html} = Reph.ReactIO.json_call!(%{
      component: "./priv/static/server/js/reph_landing.js",
      props: props,
    })

    conn
    |> put_layout("landing.html")
    |> render("index.html", html: html, props: props_client)
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end
end

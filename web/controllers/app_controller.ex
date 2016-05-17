defmodule Reph.AppController do
  use Reph.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def index(conn, %{"path" => path}) do
    connections = Reph.Connections.state()
    path = "/app/" <> Enum.join(path, "/")
    props = %{
      "location" => path,
      "initial_state" => %{"connections" => connections}
    }

    props_client = %{"connections" => connections}
    %{"html" => html} = Reph.ReactIO.json_call!(%{
      component: "./priv/static/server/js/reph_app.js",
      props: props,
    })

    conn
    |> put_layout("app.html")
    |> render("index.html", html: html, props: props_client)
  end

  def unauthenticated(conn, _params) do
    redirect(conn, to: "/")
  end
end

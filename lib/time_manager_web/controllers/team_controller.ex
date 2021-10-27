defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Task
  alias TimeManager.Task.Team

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teams = Task.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Task.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Task.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Task.get_team!(id)

    with {:ok, %Team{} = team} <- Task.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Task.get_team!(id)

    with {:ok, %Team{}} <- Task.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end

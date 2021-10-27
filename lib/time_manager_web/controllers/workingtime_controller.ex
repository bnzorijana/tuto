defmodule TimeManagerWeb.WorkingtimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Task
  alias TimeManager.Task.Workingtime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
      workingtimes = Task.list_workingtimes()
      render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params, "userId" => user_id}) do
    user = Task.get_user(user_id)
    if (user == nil) do
      conn
      |> put_status(:bad_request)
      |> put_view(TimeManagerWeb.ErrorView)
      |> render(:"400")
    else
        with {:ok, %Workingtime{} = workingtime} <- Task.create_workingtime(workingtime_params, user_id) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
        |> render("show.json", workingtime: workingtime)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    if(conn.query_params["start"] != nil and conn.query_params["end"] != nil) do
      workingtimes = Task.list_specific_workingtimes(id, conn.query_params)
      render(conn, "index.json", workingtimes: workingtimes)
    end
    if(conn.query_params == %{}) do
      workingtime = Task.get_workingtime(id)
      if (workingtime != nil) do
        render(conn, "show.json", workingtime: workingtime)
      else
        conn
        |> put_status(:not_found)
        |> put_view(TimeManagerWeb.ErrorView)
        |> render(:"404")
      end
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Task.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Task.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Task.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Task.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Task
  alias TimeManager.Task.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Task.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clocks" => clock_params, "userId" => user_param}) do
    user = Task.get_user(user_param)
    if(user != nil) do
    with {:ok, %Clock{} = clock} <- Task.create_clock(clock_params, user_param) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  else
    conn
    |> put_status(:bad_request)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(:"400")
  end
  end

  def show(conn, %{"userId" => user}) do
    clock = Task.get_clock_by_user!(user)
    if(clock != []) do
    render(conn, "index.json", clocks: clock)
  else
    conn
    |> put_status(:not_found)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(:"404")
  end

  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Task.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Task.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Task.get_clock!(id)

    with {:ok, %Clock{}} <- Task.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Task
  alias TimeManager.Task.User

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, params) do
    if(params["username"] != nil and params["email"] != nil) do
      render(conn, "show.json", user: Task.list_specific_user(params))
    end
    if(params == %{}) do
    users = Task.list_users()
    IO.inspect(conn)
    render(conn, "index.json", users: users)
      else
      conn
      |> put_status(:not_found)
      |> put_view(TimeManagerWeb.ErrorView)
      |> render(:"404")
    end
  end


  def show_members(conn, %{"teamId" => team}) do
    user = Task.get_users_by_team!(team)
    IO.inspect(user)
    if(user != []) do
      render(conn, "index.json", users: user)
    else
      conn
        |> put_status(:not_found)
        |> put_view(TimeManagerWeb.ErrorView)
        |> render(:"404")
    end
  end

  def create(conn, %{"user" => user_params}) do
    if(user_params["graph_type"] != nil) do
      if(user_params["graph_type"] != "pie" && user_params["graph_type"] != "line" && user_params["graph_type"] != "bar") do
        conn
          |> put_status(:bad_request)
          |> put_view(TimeManagerWeb.ErrorView)
          |> render(:"400")
      end
    end
    with {:ok, %User{} = user} <- Task.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Task.get_user(id)
    if(user != nil) do
      render(conn, "show.json", user: user)
    else
      conn
        |> put_status(:not_found)
        |> put_view(TimeManagerWeb.ErrorView)
        |> render(:"404")
      end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    if(user_params["graph_type"] != nil) do
      if(user_params["graph_type"] != "pie" && user_params["graph_type"] != "line" && user_params["graph_type"] != "bar") do
        conn
          |> put_status(:bad_request)
          |> put_view(TimeManagerWeb.ErrorView)
          |> render(:"400")
      end
    end
    user = Task.get_user!(id)

    with {:ok, %User{} = user} <- Task.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Task.get_user!(id)

    with {:ok, %User{}} <- Task.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

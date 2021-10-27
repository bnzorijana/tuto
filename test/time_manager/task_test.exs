defmodule TimeManager.TaskTest do
  use TimeManager.DataCase

  alias TimeManager.Task

  describe "users" do
    alias TimeManager.Task.User

    import TimeManager.TaskFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Task.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Task.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %User{} = user} = Task.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %User{} = user} = Task.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_user(user, @invalid_attrs)
      assert user == Task.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Task.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Task.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Task.change_user(user)
    end
  end

  describe "clocks" do
    alias TimeManager.Task.Clock

    import TimeManager.TaskFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Task.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Task.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2021-10-24 13:35:00]}

      assert {:ok, %Clock{} = clock} = Task.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2021-10-24 13:35:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2021-10-25 13:35:00]}

      assert {:ok, %Clock{} = clock} = Task.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2021-10-25 13:35:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_clock(clock, @invalid_attrs)
      assert clock == Task.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Task.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Task.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Task.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias TimeManager.Task.Workingtime

    import TimeManager.TaskFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Task.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Task.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{end: ~N[2021-10-24 13:46:00], start: ~N[2021-10-24 13:46:00]}

      assert {:ok, %Workingtime{} = workingtime} = Task.create_workingtime(valid_attrs)
      assert workingtime.end == ~N[2021-10-24 13:46:00]
      assert workingtime.start == ~N[2021-10-24 13:46:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{end: ~N[2021-10-25 13:46:00], start: ~N[2021-10-25 13:46:00]}

      assert {:ok, %Workingtime{} = workingtime} = Task.update_workingtime(workingtime, update_attrs)
      assert workingtime.end == ~N[2021-10-25 13:46:00]
      assert workingtime.start == ~N[2021-10-25 13:46:00]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Task.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Task.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Task.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Task.change_workingtime(workingtime)
    end
  end

  describe "teams" do
    alias TimeManager.Task.Team

    import TimeManager.TaskFixtures

    @invalid_attrs %{name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Task.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Task.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Team{} = team} = Task.create_team(valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Team{} = team} = Task.update_team(team, update_attrs)
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_team(team, @invalid_attrs)
      assert team == Task.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Task.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Task.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Task.change_team(team)
    end
  end
end

defmodule Epas.AccountTest do
  use Epas.DataCase

  alias Epas.Account

  describe "users" do
    alias Epas.Account.User

    @valid_attrs %{admin: true, email: "some email", name: "some name", token: "some token"}
    @update_attrs %{admin: false, email: "some updated email", name: "some updated name", token: "some updated token"}
    @invalid_attrs %{admin: nil, email: nil, name: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.admin == true
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.admin == false
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "logs" do
    alias Epas.Account.Log

    @valid_attrs %{info: "some info", operation: "some operation"}
    @update_attrs %{info: "some updated info", operation: "some updated operation"}
    @invalid_attrs %{info: nil, operation: nil}

    def log_fixture(attrs \\ %{}) do
      {:ok, log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_log()

      log
    end

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert Account.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert Account.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      assert {:ok, %Log{} = log} = Account.create_log(@valid_attrs)
      assert log.info == "some info"
      assert log.operation == "some operation"
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      assert {:ok, %Log{} = log} = Account.update_log(log, @update_attrs)
      assert log.info == "some updated info"
      assert log.operation == "some updated operation"
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_log(log, @invalid_attrs)
      assert log == Account.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = Account.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Account.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = Account.change_log(log)
    end
  end
end

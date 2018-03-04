defmodule ProxerEx.Test.Client do
  use ExUnit.Case, async: true

  @user_agent "ProxerEx.Test/1.2.3"
  @login_token "ThisIsATestLoginToken"
  @client_options %ProxerEx.Options{
    api_key: "abc1235",
    login_token: @login_token,
    api_host: "localhost",
    port: 4200,
    api_path: "/test_api",
    use_ssl: false,
    device: @user_agent
  }

  setup do
    {:ok, client} = start_supervised({ProxerEx.Client, @client_options})
    {:ok, %{client: client}}
  end

  test "url build from options is called", %{client: client} do
    request = %ProxerEx.Request{method: :get, api_class: "test_class", api_func: "test_func"}
    {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(client, request)
    assert response.message == "Hello, World!"
  end

  describe "test get requests" do
    test "correct get request is made", %{client: client} do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"}
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(client, request)

      assert response.data["method"] == "GET"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["header"]) >= 2
      assert Map.fetch!(response.data["header"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["header"], "user-agent") == @user_agent
    end

    test "correct get request is made with authorization", %{client: client} do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"},
        authorization: true
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(client, request)

      assert response.data["method"] == "GET"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["header"]) >= 3
      assert Map.fetch!(response.data["header"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["header"], "user-agent") == @user_agent
      assert Map.fetch!(response.data["header"], "proxer-api-token") == @login_token
    end
  end

  describe "test post requests" do
    test "correct post request is made", %{client: client} do
      request = %ProxerEx.Request{
        method: :post,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"},
        post_args: [test_post_key: "test_post_value", test2: "value_of_test2"]
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(client, request)

      assert response.data["method"] == "POST"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["header"]) >= 2
      assert Map.fetch!(response.data["header"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["header"], "user-agent") == @user_agent

      assert Enum.count(response.data["body"]) == 2
      assert Map.fetch!(response.data["body"], "test_post_key") == "test_post_value"
      assert Map.fetch!(response.data["body"], "test2") == "value_of_test2"
    end

    test "correct post request is made with authorization", %{client: client} do
      request = %ProxerEx.Request{
        method: :post,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"},
        post_args: [test_post_key: "test_post_value", test2: "value_of_test2"],
        authorization: true
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(client, request)

      assert response.data["method"] == "POST"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["header"]) >= 3
      assert Map.fetch!(response.data["header"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["header"], "user-agent") == @user_agent
      assert Map.fetch!(response.data["header"], "proxer-api-token") == @login_token

      assert Enum.count(response.data["body"]) == 2
      assert Map.fetch!(response.data["body"], "test_post_key") == "test_post_value"
      assert Map.fetch!(response.data["body"], "test2") == "value_of_test2"
    end
  end

  test "login token gets changed on set_login_token/2 call", %{client: client} do
    {:ok, %ProxerEx.Options{} = options} =
      ProxerEx.Client.set_login_token(client, "ThisIsAnotherLoginToken")

    assert options == %{@client_options | login_token: "ThisIsAnotherLoginToken"}
  end
end

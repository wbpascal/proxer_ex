defmodule ProxerEx.Test.Client do
  use ExUnit.Case, async: false
  doctest ProxerEx.Client

  import Tesla.Mock

  @user_agent "ProxerEx.Test/42.2.3"
  @login_token "ThisIsATestLoginToken"
  @client_options %ProxerEx.Options{
    host: "localhost",
    port: 4200,
    path: "/test_api",
    use_ssl: true,
    device: @user_agent
  }
  @client %ProxerEx.Client{
    key: "abc1235",
    login_token: @login_token,
    options: @client_options
  }

  setup_all do
    Tesla.Mock.mock_global(fn
      %{method: :get, url: "https://localhost:4200/test_api/v1/test_class/test_func"} ->
        json(%{"error" => 0, "message" => "Hello, World!"})

      %{
        method: :get,
        url: "https://localhost:4200/test_api/v1/test_class/ping",
        query: query,
        headers: headers
      } ->
        headers = Map.new(headers, fn {key, value} -> {String.to_atom(key), value} end)
        query = Map.new(query, fn {key, value} -> {String.to_atom(key), value} end)

        json(%{
          "error" => 0,
          "message" => "",
          "data" => %{"method" => "GET", "query" => query, "headers" => headers}
        })

      %{
        method: :post,
        url: "https://localhost:4200/test_api/v1/test_class/ping",
        query: query,
        headers: headers,
        body: body
      } ->
        headers = Map.new(headers, fn {key, value} -> {String.to_atom(key), value} end)
        query = Map.new(query, fn {key, value} -> {String.to_atom(key), value} end)

        json(%{
          "error" => 0,
          "message" => "",
          "data" => %{"method" => "POST", "query" => query, "headers" => headers, "body" => body}
        })

      env ->
        json(%{"error" => 1, "message" => "Error", "data" => env})
    end)

    :ok
  end

  test "url build from options is called" do
    request = %ProxerEx.Request{method: :get, api_class: "test_class", api_func: "test_func"}
    {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(request, @client)
    assert response.message == "Hello, World!"
  end

  describe "test get requests" do
    test "correct get request is made" do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"}
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(request, @client)

      assert response.data["method"] == "GET"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["headers"]) >= 2
      assert Map.fetch!(response.data["headers"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["headers"], "User-Agent") == @user_agent
    end

    test "correct get request is made with authorization" do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"},
        authorization: true
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(request, @client)

      assert response.data["method"] == "GET"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["headers"]) >= 3
      assert Map.fetch!(response.data["headers"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["headers"], "User-Agent") == @user_agent
      assert Map.fetch!(response.data["headers"], "proxer-api-token") == @login_token
    end
  end

  describe "test post requests" do
    test "correct post request is made" do
      request = %ProxerEx.Request{
        method: :post,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"},
        post_args: [test_post_key: "test_post_value", test2: "value_of_test2"]
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(request, @client)

      assert response.data["method"] == "POST"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["headers"]) >= 2
      assert Map.fetch!(response.data["headers"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["headers"], "User-Agent") == @user_agent

      assert response.data["body"] == "test_post_key=test_post_value&test2=value_of_test2"
    end

    test "correct post request is made with authorization" do
      request = %ProxerEx.Request{
        method: :post,
        api_class: "test_class",
        api_func: "ping",
        get_args: %{"test_key" => "test_value"},
        post_args: [test_post_key: "test_post_value", test2: "value_of_test2"],
        authorization: true
      }

      {:ok, %ProxerEx.Response{} = response} = ProxerEx.Client.make_request(request, @client)

      assert response.data["method"] == "POST"

      assert Enum.count(response.data["query"]) == 1
      assert Map.fetch!(response.data["query"], "test_key") == "test_value"

      assert Enum.count(response.data["headers"]) >= 3
      assert Map.fetch!(response.data["headers"], "proxer-api-key") == "abc1235"
      assert Map.fetch!(response.data["headers"], "User-Agent") == @user_agent
      assert Map.fetch!(response.data["headers"], "proxer-api-token") == @login_token

      assert response.data["body"] == "test_post_key=test_post_value&test2=value_of_test2"
    end
  end
end

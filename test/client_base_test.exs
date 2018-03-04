defmodule ProxerEx.Test.Client.Base do
  use ExUnit.Case, async: true

  @client_options %ProxerEx.Options{
    api_key: "abc1235",
    api_host: "localhost",
    port: 4200,
    api_path: "/test_api",
    use_ssl: false
  }
  @replace_text "REPLACE_THIS_TEXT_IN_PROCESS_RAW_RESPONSE"

  def get_replace_text(), do: @replace_text

  defmodule TestClient do
    use ProxerEx.Client.Base

    def process_header(header) do
      {:ok, Keyword.put(header, :"test-header", "header value for test")}
    end

    def process_url(url) do
      new_query = %{"new_args" => "arg_value"} |> URI.encode_query()
      {:ok, %URI{URI.parse(url) | query: new_query} |> URI.to_string()}
    end

    def process_post_args(post_args) do
      post_args = if !Keyword.keyword?(post_args), do: [], else: post_args
      {:ok, Keyword.put(post_args, :test_post_key, "test value for new post key")}
    end

    def process_raw_response(body) when is_bitstring(body) do
      {:ok, String.replace(body, ProxerEx.Test.Client.Base.get_replace_text(), "new value")}
    end

    def process_parsed_response(%ProxerEx.Response{} = response) do
      {:ok, %{response | message: "new message"}}
    end
  end

  setup_all do
    {:ok, client} = start_supervised({TestClient, @client_options})
    {:ok, %{client: client}}
  end

  describe "callbacks are called on each request" do
    test "overridden process_header is called", %{client: client} do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping"
      }

      {:ok, %ProxerEx.Response{} = response} = TestClient.make_request(client, request)

      assert Map.fetch!(response.data["header"], "test-header") == "header value for test"
    end

    test "overridden process_url is called", %{client: client} do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping"
      }

      {:ok, %ProxerEx.Response{} = response} = TestClient.make_request(client, request)

      assert Map.fetch!(response.data["query"], "new_args") == "arg_value"
    end

    test "overridden process_post_args is called", %{client: client} do
      request = %ProxerEx.Request{
        method: :post,
        api_class: "test_class",
        api_func: "ping"
      }

      {:ok, %ProxerEx.Response{} = response} = TestClient.make_request(client, request)

      assert Map.fetch!(response.data["body"], "test_post_key") == "test value for new post key"
    end

    test "overridden process_raw_response is called", %{client: client} do
      request = %ProxerEx.Request{
        method: :post,
        api_class: "test_class",
        api_func: "ping",
        post_args: [process_key: @replace_text]
      }

      {:ok, %ProxerEx.Response{} = response} = TestClient.make_request(client, request)

      assert Map.fetch!(response.data["body"], "process_key") == "new value"
    end

    test "overridden process_parsed_response is called", %{client: client} do
      request = %ProxerEx.Request{
        method: :get,
        api_class: "test_class",
        api_func: "ping"
      }

      {:ok, %ProxerEx.Response{} = response} = TestClient.make_request(client, request)

      assert response.message == "new message"
    end
  end
end

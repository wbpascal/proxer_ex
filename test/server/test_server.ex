defmodule TestServer do
  @moduledoc false

  use Ace.HTTP.Service, port: 4200, cleartext: true

  @impl Raxx.Server
  def handle_request(%{method: :GET, path: ["test_api", "v1", "test_class", "test_func"]}, _) do
    response(:ok)
    |> set_header("content-type", "application/json")
    |> set_body(~s({"error": 0, "message": "Hello, World!"}))
  end

  def handle_request(
        %{
          method: :GET,
          path: ["test_api", "v1", "test_class", "ping"],
          query: query,
          headers: header
        },
        _
      ) do
    header_json = header |> headers_to_map() |> Poison.encode!()
    query_json = Poison.encode!(query)

    response(:ok)
    |> set_header("content-type", "application/json")
    |> set_body(
      ~s({"error": 0, "message": "", "data": {"method": "GET", "query": #{query_json}, "header": #{
        header_json
      }}})
    )
  end

  def handle_request(
        %{
          method: :POST,
          path: ["test_api", "v1", "test_class", "ping"],
          query: query,
          headers: header,
          body: body
        },
        _
      ) do
    header_json = header |> headers_to_map() |> Poison.encode!()
    query_json = Poison.encode!(query)

    body_json =
      body
      |> String.replace("+", " ")
      |> String.split("&")
      |> Enum.map(&String.split(&1, "="))
      |> Enum.filter(fn elem -> Enum.count(elem) == 2 end)
      |> Enum.reduce(%{}, fn [key, value], acc -> Map.put(acc, key, value) end)
      |> Poison.encode!()

    response(:ok)
    |> set_header("content-type", "application/json")
    |> set_body(
      ~s({"error": 0, "message": "", "data": {"method": "POST", "query": #{query_json}, "header": #{
        header_json
      }, "body": #{body_json}}})
    )
  end

  def handle_request(_request, _) do
    response(404)
  end

  def headers_to_map([{header, value} | rest]) do
    rest
    |> headers_to_map()
    |> Map.put(header, value)
  end

  def headers_to_map([]), do: %{}
end

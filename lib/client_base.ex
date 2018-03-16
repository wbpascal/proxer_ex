defmodule ProxerEx.Client.Base do
  @moduledoc """
    Provides a default implementation for the Proxer API client.
  """

  @type response :: {:ok, ProxerEx.Response.t()} | {:error, any()}

  defmacro __using__(_) do
    quote do
      use GenServer

      @spec make_request(
              client :: GenServer.server(),
              request :: ProxerEx.Request.t()
            ) :: {:ok, ProxerEx.Response.t()} | {:error, any()}
      def make_request(client, %ProxerEx.Request{} = request) do
        case GenServer.call(client, {:request, request}) do
          {:ok, %ProxerEx.Response{} = response} -> {:ok, response}
          {:error, error} -> {:error, error}
          error -> {:error, error}
        end
      end

      @spec set_login_token(client :: pid(), token :: binary()) ::
              {:ok, ProxerEx.Options.t()} | {:error, any()}
      def set_login_token(client, token) when is_pid(client) do
        case GenServer.call(client, {:set_token, token}) do
          {:ok, %ProxerEx.Options{} = options} -> {:ok, options}
          {:error, error} -> {:error, error}
          error -> {:error, error}
        end
      end

      @spec create_request(request :: ProxerEx.Request.t(), options :: ProxerEx.Options.t()) ::
              {:ok, ProxerEx.Response.t()} | {:error, any()}
      defp create_request(
             %ProxerEx.Request{method: method, post_args: post_args} = request,
             %ProxerEx.Options{} = options
           ) do
        with {:ok, url} <- create_api_url(request, options),
             {:ok, header} <- create_headers(request, options),
             {:ok, post_args} <-
               if(method == :post, do: process_post_args(post_args), else: {:ok, post_args}),
             {:ok, %HTTPoison.Response{body: body, status_code: 200}} <-
               do_request(method, url, post_args, header),
             {:ok, %ProxerEx.Response{} = response} <- parse_response_body(body) do
          {:ok, response}
        else
          {:error, error} -> {:error, error}
          {:ok, %HTTPoison.Response{} = response} -> {:error, response}
          error -> {:error, error}
        end
      end

      @spec create_api_url(request :: ProxerEx.Request.t(), options :: ProxerEx.Options.t()) ::
              {:ok, binary()} | {:error, any()}
      defp create_api_url(
             %ProxerEx.Request{get_args: query_args, api_class: api_class, api_func: api_func},
             %ProxerEx.Options{api_host: host, api_path: path, port: port, use_ssl: use_ssl}
           ) do
        query = query_args |> URI.encode_query()

        uri =
          %URI{
            scheme: "http#{if use_ssl, do: "s"}",
            host: host,
            port: port,
            path: "#{path}/v1/#{api_class}/#{api_func}",
            query: query
          }
          |> URI.to_string()

        case process_url(uri) do
          {:ok, uri} -> {:ok, uri}
          {:error, error} -> {:error, error}
          error -> {:error, error}
        end
      end

      @spec create_headers(request :: ProxerEx.Request.t(), options :: ProxerEx.Options.t()) ::
              {:ok, keyword(binary())} | {:error, any()}
      defp create_headers(
             %ProxerEx.Request{extra_header: header, authorization: authorization},
             %ProxerEx.Options{api_key: api_key, login_token: login_token, device: device}
           ) do
        header =
          header
          |> Keyword.put_new(:"proxer-api-key", api_key)
          |> Keyword.put_new(:"User-Agent", device)

        header =
          if authorization and login_token != nil do
            header |> Keyword.put_new(:"proxer-api-token", login_token)
          else
            header
          end

        case process_header(header) do
          {:ok, header} -> {:ok, header}
          {:error, error} -> {:error, error}
          error -> {:error, error}
        end
      end

      @spec do_request(
              method :: ProxerEx.Request.http_method(),
              url :: binary(),
              post_args :: keyword(binary()),
              header :: keyword(binary())
            ) :: {:ok, HTTPoison.Response.t()} | {:error, any()}
      defp do_request(method, url, post_args, header) do
        HTTPoison.request(
          method,
          url,
          {:form, post_args},
          header,
          ssl: [{:versions, [:"tlsv1.2"]}]
        )
      end

      @spec parse_response_body(body :: binary()) ::
              {:ok, ProxerEx.Response.t()} | {:error, any()}
      defp parse_response_body(body) do
        with {:ok, body} <- process_raw_response(body),
             {:ok, %ProxerEx.Response{} = response} <-
               Poison.decode(body, as: %ProxerEx.Response{}),
             {:ok, %ProxerEx.Response{} = response} <- process_parsed_response(response) do
          {:ok, response}
        else
          {:error, error} -> {:error, error}
          error -> {:error, error}
        end
      end

      # overridable functions

      @spec process_header(header :: keyword(binary())) ::
              {:ok, keyword(binary())} | {:error, any()}
      def process_header(header), do: {:ok, header}

      @spec process_url(url :: binary()) :: {:ok, binary()} | {:error, any()}
      def process_url(url), do: {:ok, url}

      @spec process_post_args(post_args :: keyword(binary())) ::
              {:ok, keyword(binary())} | {:error, any()}
      def process_post_args(post_args), do: {:ok, post_args}

      @spec process_raw_response(body :: binary()) :: {:ok, binary()} | {:error, any()}
      def process_raw_response(body), do: {:ok, body}

      @spec process_parsed_response(response :: ProxerEx.Response.t()) ::
              {:ok, ProxerEx.Response.t()} | {:error, any()}
      def process_parsed_response(response), do: {:ok, response}

      defoverridable process_header: 1,
                     process_url: 1,
                     process_post_args: 1,
                     process_raw_response: 1,
                     process_parsed_response: 1

      # GenServer callbacks

      @spec start_link(args :: ProxerEx.Options.t(), opts :: GenServer.options()) ::
              GenServer.on_start()
      def start_link(%ProxerEx.Options{} = args, opts \\ []) do
        GenServer.start_link(__MODULE__, args, opts)
      end

      def init(%ProxerEx.Options{} = args) do
        {:ok, args}
      end

      def init(_) do
        {:error, "Invalid arguments"}
      end

      def handle_call(
            {:request, %ProxerEx.Request{} = request},
            _from,
            %ProxerEx.Options{} = args
          ) do
        {:reply, create_request(request, args), args}
      end

      def handle_call({:set_token, token}, _from, %ProxerEx.Options{} = args) do
        new_args = %{args | login_token: token}
        {:reply, {:ok, new_args}, new_args}
      end

      # Catchall methods (call, cast, info)

      def handle_call(_, _from, state) do
        {:reply, {:error, "Invalid arguments"}, state}
      end

      def handle_cast(_, state) do
        {:noreply, state}
      end

      def handle_info(_, state) do
        {:noreply, state}
      end
    end
  end
end

defmodule ProxerEx.Api.Base do
  @moduledoc "Proxer api module base"

  @type request :: {:ok, ProxerEx.Request.t()} | {:error, any()}

  defmacro __using__(api_class: api_class) do
    quote do
      import ProxerEx.Api.Base

      @api_class_name unquote(api_class)

      defp test_required_params_given(func_params, actual_params) do
        missing_params =
          func_params
          |> Enum.filter(fn
            {name, method, true, process} -> Keyword.get(actual_params, name) == nil
            _ -> false
          end)
          |> Enum.map(fn {name, _, _, _} -> name end)

        unless Enum.empty?(missing_params) do
          {:error, "The following required parameters are not given: #{inspect(missing_params)}"}
        end

        :ok
      end

      defp process_all_params(func_params, actual_params, request) do
        {request, errors} = process_param(func_params, actual_params, request)

        if Enum.empty?(errors) do
          {:ok, request}
        else
          {:error, "The following parameters failed to process: #{inspect(errors)}"}
        end
      end

      defp process_param([{name, _, optional, process, not_with} | rest], actual_params, request) do
        {request, new_errors} =
          with {:has_key, true} <- {:has_key, Keyword.has_key?(actual_params, name)},
               {:not_with, []} <-
                 {:not_with,
                  Enum.filter(not_with, fn x ->
                    Keyword.has_key?(actual_params, String.to_atom(x))
                  end)},
               value <- Keyword.get(actual_params, name),
               {:ok, request} <- Kernel.apply(__MODULE__, process, [request, name, value]) do
            {request, []}
          else
            {:error, reason} ->
              {request, [{:error, reason}]}

            {:not_with, conflicts} ->
              {request,
               [
                 {:error,
                  "the following parameter are not allowed, when \'#{inspect(name)}\' is given, but were passed to the function: #{
                    conflicts
                  }"}
               ]}

            {:has_key, false} ->
              not_with_params =
                Enum.filter(not_with, fn x ->
                  Keyword.has_key?(actual_params, String.to_atom(x))
                end)

              errors =
                if optional or not_with_params != [] do
                  # if the parameter is optional or any of the parameter given in
                  # :not_with are given then the processing should pass
                  []
                else
                  [
                    "\'#{inspect(name)}\' is not an optional parameter and therefore must be given"
                  ]
                end

              {request, errors}

            error ->
              {request, [{:error, error}]}
          end

        {request, errors} = process_param(rest, actual_params, request)
        {request, errors ++ new_errors}
      end

      defp process_param([], _, request), do: {request, []}

      @doc false
      def add_get_parameter(%ProxerEx.Request{get_args: get_args} = request, name, value) do
        get_args = Map.put(get_args, name, value)
        {:ok, %ProxerEx.Request{request | get_args: get_args}}
      end

      @doc false
      def add_post_parameter(%ProxerEx.Request{post_args: post_args} = request, name, value) do
        post_args = Keyword.put(post_args, name, value)
        {:ok, %ProxerEx.Request{request | post_args: post_args}}
      end
    end
  end

  defmacro __using__(_) do
    raise "api_class argument musst be specified! See documentation for further information"
  end

  @doc """
    :process is only called if a value was given to the method
  """
  defmacro parameter(name, method, opts \\ []) when is_binary(name) and is_atom(method) do
    quote do
      with {:opts, true} <- {:opts, Keyword.keyword?(unquote(opts))},
           optional <- Keyword.get(unquote(opts), :optional, false),
           {:optional, true} <- {:optional, is_boolean(optional)},
           process <-
             Keyword.get(unquote(opts), :process, unquote(get_default_process_method(method))),
           {:process, true} <- {:process, {process, 3} in Module.definitions_in(__MODULE__)},
           not_with <- Keyword.get(unquote(opts), :not_with, []),
           {:not_with, true} <- {:not_with, is_list(not_with)} do
        @func_params {unquote(String.to_atom(name)), unquote(method), optional, process, not_with}
      else
        {:opts, false} ->
          raise(ArgumentError, "opts must be a keyword list, got: #{inspect(unquote(opts))}")

        {:optional, false} ->
          raise(ArgumentError, "optional must be a boolean")

        {:process, false} ->
          raise(ArgumentError, "process must be a name of a function with an arity of 3")

        {:not_with, false} ->
          raise(ArgumentError, "not_with must be a list")
      end
    end
  end

  defmacro paging_parameters() do
    quote do
      parameter("p", :get, optional: true)
      parameter("limit", :get, optional: true)
    end
  end

  def get_default_process_method(:get), do: :add_get_parameter

  def get_default_process_method(:post), do: :add_post_parameter

  defmacro api_doc(doc) do
    unless is_binary(doc) do
      raise(ArgumentError, "doc must be a string, got: #{inspect(doc)}")
    end

    quote do
      unless @func_params do
        raise(ArgumentError, "must be called inside api_func")
      end

      @doc unquote(doc)
    end
  end

  defmacro api_func(func_name, opts \\ [], do: block) do
    add_api_func(func_name, Keyword.put(opts, :do, block))
  end

  defp add_api_func(func_name, opts) do
    unless is_binary(func_name) do
      raise ArgumentError, "api function name must be a string, got: #{inspect(func_name)}"
    end

    {authorization, extra_header, block} = check_api_func_opts(opts)

    quote do
      Module.register_attribute(__MODULE__, :func_params, accumulate: true)

      try do
        unquote(block)

        @spec unquote(String.to_atom(escape_function_name(func_name)))(keyword()) ::
                ProxerEx.Api.Client.Base.request()
        def unquote(String.to_atom(escape_function_name(func_name)))(params \\ []) do
          request = %ProxerEx.Request{
            method: :get,
            api_class: @api_class_name,
            api_func: unquote(func_name),
            extra_header: unquote(extra_header),
            authorization: unquote(authorization)
          }

          with func_params <- @func_params,
               :ok <- test_required_params_given(func_params, params),
               {:ok, request} <- process_all_params(func_params, params, request) do
            request =
              if Enum.count(request.post_args) > 0,
                do: %{request | method: :post},
                else: request

            {:ok, request}
          else
            {:error, error} -> {:error, error}
            error -> {:error, error}
          end
        end
      after
        Module.delete_attribute(__MODULE__, :func_params)
      end
    end
  end

  defp check_api_func_opts(opts) do
    with authorization <- Keyword.get(opts, :authorization, false),
         {:authorization, true} <- {:authorization, is_boolean(authorization)},
         extra_header <- Keyword.get(opts, :extra_header, []),
         {:extra_header, true} <- {:extra_header, Keyword.keyword?(extra_header)},
         block <- Keyword.get(opts, :do, get_empty_block()) do
      {authorization, extra_header, block}
    else
      {:authorization, false} -> raise ArgumentError, "authorization must be a boolean"
      {:extra_header, false} -> raise ArgumentError, "extra_header must be a keyword list"
    end
  end

  defp get_empty_block() do
    quote do
    end
  end

  # Escapes function name so that it conforms to the standards
  defp escape_function_name(name) do
    name |> String.trim() |> String.replace(" ", "") |> Macro.underscore()
  end
end

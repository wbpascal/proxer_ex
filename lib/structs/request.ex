defmodule ProxerEx.Request do
  @type http_method :: :get | :post

  @type t :: %ProxerEx.Request{
          method: http_method(),
          api_class: binary(),
          api_func: binary(),
          get_args: %{optional(binary()) => binary()},
          post_args: keyword(binary()),
          extra_header: keyword(binary()),
          authorization: boolean()
        }
  @enforce_keys [:method, :api_class, :api_func]
  defstruct [
    :method,
    :api_class,
    :api_func,
    get_args: %{},
    post_args: [],
    extra_header: [],
    authorization: false
  ]
end

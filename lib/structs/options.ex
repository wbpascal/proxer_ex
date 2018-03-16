defmodule ProxerEx.Options do
  @type t :: %ProxerEx.Options{
          api_key: binary(),
          login_token: binary(),
          device: binary(),
          api_host: binary(),
          api_path: binary(),
          port: integer(),
          use_ssl: boolean()
        }
  @enforce_keys [:api_key]
  defstruct [
    :api_key,
    :login_token,
    :port,
    device: "ProxerEx/#{ProxerEx.MixProject.project()[:version]}",
    api_host: "proxer.me",
    api_path: "/api",
    use_ssl: true
  ]
end

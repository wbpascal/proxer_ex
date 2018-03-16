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
    device: "ProxerEx/#{ProxerEx.MixProject.project()[:version]}",
    api_host: "proxer.me",
    api_path: "/api",
    port: 80,
    use_ssl: true
  ]
end

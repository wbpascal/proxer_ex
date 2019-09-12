defmodule ProxerEx.Options do
  @moduledoc "Client options struct"

  @type t :: %ProxerEx.Options{
          device: binary(),
          host: binary(),
          path: binary(),
          port: integer() | nil,
          use_ssl: boolean()
        }
  defstruct [
    :port,
    device: "ProxerEx/#{ProxerEx.MixProject.project()[:version]}",
    host: "proxer.me",
    path: "/api",
    use_ssl: true
  ]
end

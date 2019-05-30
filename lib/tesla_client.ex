defmodule ProxerEx.TeslaClient do
  # Custom Tesla client so we can use the middleware
  @moduledoc false

  use Tesla

  plug(Tesla.Middleware.Timeout, timeout: 10_000)
  plug(Tesla.Middleware.FormUrlencoded)
  plug(Tesla.Middleware.DecodeJson)
end

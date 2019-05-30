defmodule ProxerEx.Response do
  @moduledoc "Proxer response struct"

  @type t :: %ProxerEx.Response{
          error: boolean(),
          message: binary(),
          data: any(),
          code: integer()
        }
  defstruct [:error, :message, :data, :code]
end

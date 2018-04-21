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

defimpl Poison.Decoder, for: ProxerEx.Response do
  def decode(%ProxerEx.Response{error: error} = value, _options) do
    %{value | :error => error == 1}
  end

  def decode(value, _options) do
    value
  end
end

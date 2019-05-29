defmodule ProxerEx.Helper.KeywordHelper do
  @moduledoc false

  @doc """
  Converts the keys of the keyword list to strings but leaves the values as is.
  """
  @spec to_string_list(keyword()) :: [{binary(), any()}]
  def to_string_list(keyword) do
    keyword
    |> Enum.map(fn
      {key, value} when is_atom(key) -> {Atom.to_string(key), value}
      tuple -> tuple
    end)
  end
end

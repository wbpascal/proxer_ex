defmodule ProxerEx.Helper.MapHelper do
  @moduledoc false

  def to_atom_map(map) do
    Map.new(
      map,
      fn
        {key, value} when is_binary(key) -> {String.to_atom(key), value}
        tuple -> tuple
      end
    )
  end
end

defmodule Cookbook.Examples do
  use NimblePublisher,
    build: Cookbook.Example,
    from: "priv/content/**/*.markdown",
    as: :examples,
    highlighters: [:makeup_elixir, :makeup_erlang]

  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  def all_examples, do: Map.new(@examples, &{&1.id, &1})

  def examples_by_prefix(prefix) do
    Enum.filter(all_examples(), fn {example_id, _example} ->
      String.starts_with?(example_id, prefix)
    end)
  end
end

defmodule Cookbook.Examples do
  use NimblePublisher,
    build: Cookbook.Example,
    from: "priv/content/**/*.markdown",
    as: :examples,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @examples Enum.sort_by(@examples, & &1.title)

  def all_examples, do: @examples
end

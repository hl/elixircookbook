defmodule Cookbook.Recipes do
  use NimblePublisher,
    build: Cookbook.Recipe,
    from: "priv/content/**/*.markdown",
    as: :recipes,
    highlighters: [:makeup_elixir, :makeup_erlang]

  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  def all_recipes, do: Map.new(@recipes, &{&1.id, &1})

  def recipes_by_prefix(prefix) do
    Enum.filter(all_recipes(), fn {recipe_id, _recipe} ->
      String.starts_with?(recipe_id, prefix)
    end)
  end
end

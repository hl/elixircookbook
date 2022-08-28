defmodule Cookbook.Pages do
  use NimblePublisher,
    build: Cookbook.Page,
    from: "priv/content/**/*.md",
    as: :pages,
    highlighters: [:makeup_elixir, :makeup_erlang]

  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  @pages Map.new(@pages, &{&1.id, &1})

  def all_pages, do: @pages

  def get_page_by_id!(id) do
    Map.get(all_pages(), id) ||
      raise NotFoundError, "page with id=#{id} not found"
  end

  def get_functions(id) do
    Enum.filter(all_pages(), fn
      {page_id, %{type: :function}} -> String.starts_with?(page_id, id)
      _page -> false
    end)
  end
end

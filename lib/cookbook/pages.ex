defmodule Cookbook.Pages do
  use NimblePublisher,
    build: Cookbook.Page,
    from: "priv/content/**/*.md",
    as: :pages,
    highlighters: [:makeup_elixir, :makeup_erlang]

  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  @pages Enum.sort_by(@pages, & &1.title)

  def all_pages, do: @pages

  def get_page_by_id!(id) do
    Enum.find(all_pages(), &(&1.id == id)) ||
      raise NotFoundError, "page with id=#{id} not found"
  end
end

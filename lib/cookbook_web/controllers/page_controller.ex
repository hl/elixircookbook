defmodule CookbookWeb.PageController do
  use CookbookWeb, :controller

  alias Cookbook.Pages
  alias Cookbook.Examples

  def index(conn, _params) do
    pages = Pages.all_modules()
    render(conn, "index.html", pages: pages)
  end

  def show(conn, %{"path" => path}) do
    id = Enum.join(path, "/")
    page = Pages.get_page_by_id!(id)

    case page.type do
      :module ->
        functions = Pages.get_functions(id)
        render(conn, "module.html", page: page, functions: functions)

      :function ->
        examples = Examples.examples_by_prefix(id)
        render(conn, "function.html", page: page, examples: examples)
    end
  end

  def livebook(conn, %{"path" => path}) do
    id = Enum.join(path, "/")
    file = File.read!(Application.app_dir(:cookbook, "priv/content/" <> id))
    send_resp(conn, 200, file)
  end
end

defmodule CookbookWeb.PageController do
  use CookbookWeb, :controller

  alias Cookbook.Pages
  alias Cookbook.Recipes

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
        recipes = Recipes.recipes_by_prefix(id)
        render(conn, "function.html", page: page, recipes: recipes)
    end
  end

  def livebook(conn, %{"path" => path}) do
    id = Enum.join(path, "/")
    path = Application.app_dir(:cookbook, "priv/content/" <> id)

    send_download(conn, {:file, path})
  end
end

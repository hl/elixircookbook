defmodule CookbookWeb.PageController do
  use CookbookWeb, :controller

  alias Cookbook.Pages

  def index(conn, _params) do
    pages = Pages.all_pages()
    render(conn, "index.html", pages: pages)
  end

  def show(conn, %{"path" => path}) do
    id = Enum.join(path, "/")
    page = Pages.get_page_by_id!(id)
    template = "#{page.type}.html"
    render(conn, template, page: page)
  end
end

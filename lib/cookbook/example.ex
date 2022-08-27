defmodule Cookbook.Example do
  use TypedStruct

  typedstruct do
    field :id, String.t(), enforce: true
    field :github_username, String.t(), enforce: true
    field :title, String.t(), enforce: true
    field :docs, String.t(), enforce: true
    field :body, String.t(), enforce: true
  end

  def build(filename, attrs, _body) do
    id =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.reject(&(&1 in ~w/priv content examples/))
      |> Enum.join("/")

    livebook_contents =
      filename
      |> String.replace(".md", ".livemd")
      |> File.read!()

    body =
      ("```elixir\n" <> livebook_contents <> "\n```")
      |> Earmark.as_html!()
      |> NimblePublisher.Highlighter.highlight()

    struct!(__MODULE__, [id: id, body: body] ++ Map.to_list(attrs))
  end
end

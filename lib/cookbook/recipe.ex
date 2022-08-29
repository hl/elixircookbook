defmodule Cookbook.Recipe do
  use TypedStruct

  typedstruct do
    field :id, String.t(), enforce: true
    field :github_username, String.t(), enforce: true
    field :title, String.t(), enforce: true
    field :docs, String.t(), enforce: true
    field :body, String.t(), enforce: true
  end

  def build(filename, attrs, body) do
    id =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.reject(&(&1 in ~w/priv content/))
      |> Enum.join("/")

    livebook_contents =
      filename
      |> String.replace(".markdown", ".livemd")
      |> File.read!()

    livebook_body =
      livebook_contents
      |> Earmark.as_html!()
      |> NimblePublisher.Highlighter.highlight()

    struct!(__MODULE__, [id: id, body: body <> livebook_body] ++ Map.to_list(attrs))
  end
end

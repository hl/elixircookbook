defmodule Cookbook.Page do
  use TypedStruct

  typedstruct do
    field :id, String.t(), enforce: true
    field :title, String.t(), enforce: true
    field :docs, String.t(), enforce: true
    field :body, String.t(), enforce: true
    field :type, String.t(), enforce: true
  end

  def build(filename, attrs, body) do
    id =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.reject(&(&1 in ~w/priv content/))
      |> Enum.join("/")

    struct!(__MODULE__, [id: id, body: body] ++ Map.to_list(attrs))
  end
end

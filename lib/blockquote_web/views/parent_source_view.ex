defmodule BlockquoteWeb.ParentSourceView do
  use BlockquoteWeb, :view
  
  def to_s(parent_source) do
    to_s(parent_source.title, parent_source.subtitle)
  end
  
  def to_s(title, nil) do
    title
  end
  
  def to_s(title, subtitle) do
    title <> ": " <> subtitle
  end
  
  
  @doc """
  Maps a list of parent sources into tuples, used for forms
  """
  def map_for_form(parent_sources) do
    Enum.map(parent_sources, &{to_s(&1), &1.id})
  end
  
  def item_columns(conn, parent_source) do
    [
      {"title", parent_source.title},
      {"subtitle", parent_source.subtitle},
      {"source type", link(BlockquoteWeb.SourceTypeView.to_s(parent_source.source_type), to: source_type_path(conn, :show, parent_source.source_type))},
      {"url", BlockquoteWeb.SharedView.linkify(parent_source.url)}, 
    ]
  end
  
  
  def form_fields(items) do
    [
      {:title, :string, nil},
      {:subtitle, :string, nil},
      {:source_type_id, :select, items[:source_types]},
      {:url, :string, nil},
    ]
  end
end

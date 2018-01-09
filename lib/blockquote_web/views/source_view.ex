defmodule BlockquoteWeb.SourceView do
  use BlockquoteWeb, :view
  
  def to_s(source) do
    to_s(source.title, source.subtitle)
  end
  
  def to_s(title, nil) do
    title
  end
  
  def to_s(title, subtitle) do
    title <> ": " <> subtitle
  end
  
  @doc """
  Maps a list of sources into tuples, used for forms
  """
  def map_for_form(sources) do
    Enum.map(sources, &{to_s(&1), &1.id})
  end
  
  def item_columns(conn, source) do
    parent_source_link = case is_nil(source.parent_source) do
      false ->
        link(BlockquoteWeb.ParentSourceView.to_s(source.parent_source), to: parent_source_path(conn, :show, source.parent_source))
      true ->
        nil
    end
    
    [
      {"title", source.title},
      {"subtitle", source.subtitle},
      {"author", link(BlockquoteWeb.AuthorView.to_s(source.author), to: author_path(conn, :show, source.author))},
      {"source type", link(BlockquoteWeb.SourceTypeView.to_s(source.source_type), to: source_type_path(conn, :show, source.source_type))},
      {"parent source", parent_source_link},
      {"url", BlockquoteWeb.SharedView.linkify(source.url)}, 
    ]
  end
  
  
  def form_fields(items) do
    [
      {:title, :string, nil},
      {:subtitle, :string, nil},
      {:author_id, :select, items[:authors]},
      {:source_type_id, :select, items[:source_types]},
      {:parent_source_id, :select, items[:parent_sources]},
      {:url, :string, nil},
    ]
  end
end

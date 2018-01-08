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
end

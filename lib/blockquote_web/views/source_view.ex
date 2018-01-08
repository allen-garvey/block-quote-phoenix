defmodule BlockquoteWeb.SourceView do
  use BlockquoteWeb, :view
  
  def to_s(source) do
    source.title
  end
  
  @doc """
  Maps a list of sources into tuples, used for forms
  """
  def map_for_form(sources) do
    Enum.map(sources, &{to_s(&1), &1.id})
  end
end

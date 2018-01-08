defmodule BlockquoteWeb.SourceTypeView do
  use BlockquoteWeb, :view
  
  def to_s(source_type) do
    source_type.name
  end
  
  @doc """
  Maps a list of source types into tuples, used for forms
  """
  def map_for_form(source_types) do
    Enum.map(source_types, &{to_s(&1), &1.id})
  end
end

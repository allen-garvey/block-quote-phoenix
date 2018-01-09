defmodule BlockquoteWeb.CategoryView do
  use BlockquoteWeb, :view
  
  def to_s(category) do
    category.name
  end
  
  @doc """
  Maps a list of categories into tuples, used for forms
  """
  def map_for_form(categories) do
    Enum.map(categories, &{to_s(&1), &1.id})
  end
  
  def item_columns(_conn, category) do
    [
      {"name", category.name}, 
    ]
  end
  
  
  def form_fields() do
    [
      {:name, :string, nil},
    ]
  end
  
end

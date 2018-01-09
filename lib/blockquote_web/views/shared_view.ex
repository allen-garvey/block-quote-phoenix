defmodule BlockquoteWeb.SharedView do
  use BlockquoteWeb, :view
  
  @doc """
  	Naive implementation of function to pluralize string
  	"""
	def naive_pluralize(singular) do
		if String.ends_with? singular, "y" do
		  String.replace_trailing(singular, "y", "ies")
		else
			singular <> "s"
		end
	end

	@doc """
  	Used to generate name for path helper function
  	"""
	def item_path_func_name(item_name_singular) do
		String.to_atom(String.replace(item_name_singular, " ", "_") <> "_path")
	end

	@doc """
  	Returns path for item
  	(e.g. :index, :show, :new)
  	"""
	def path_for_item(conn, item_name_singular, path_atom) do
		apply(BlockquoteWeb.Router.Helpers, item_path_func_name(item_name_singular), [conn, path_atom])
	end

	@doc """
  	Returns path for item instance
  	(e.g. :edit and :show)
  	"""
	def path_for_item(conn, item_name_singular, path_atom, item_instance) do
		apply(BlockquoteWeb.Router.Helpers, item_path_func_name(item_name_singular), [conn, path_atom, item_instance])
	end
	
	@doc """
  	Returns inserted_at date as string for ecto model
  	"""
  	def item_date_created(item) do
  		"#{item.inserted_at.year}-#{pad_date_digit(item.inserted_at.month)}-#{pad_date_digit(item.inserted_at.day)} #{pad_date_digit(item.inserted_at.hour)}:#{pad_date_digit(item.inserted_at.minute)}"
  	end
  	
  	def pad_date_digit(digit) do
  		Integer.to_string(digit) |> String.pad_leading(2, ["0"])
  	end
end
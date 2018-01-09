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
  	
  	@doc """
  	Used to turn a url that might be nil into a link
  	"""
  	def linkify(nil) do
  		nil
  	end
  	
  	def linkify(url) do
  		link(url, to: url)
  	end
  	
  	
  	@doc """
  	Used for forms to determine if required
  	"""
  	def field_required?(field_atom, required_fields) do
  		required_fields |> Enum.member?(field_atom)
  	end
  	
  	def field_required_label_class(true) do
  		"required"
  	end
  	
  	def field_required_label_class(false) do
  		""
  	end
  	
	def form_item_label(f, field, required_fields) do
		label f, field, class: "control-label " <> field_required_label_class(field_required?(field, required_fields))
	end
	
	def form_input(f, :string, field, required_fields, nil) do
		text_input(f, field, class: "form-control", required: field_required?(field, required_fields))
	end
	
	def form_input(f, :text, field, required_fields, nil) do
		textarea(f, field, class: "form-control", required: field_required?(field, required_fields))
	end
end
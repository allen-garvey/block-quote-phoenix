defmodule BlockquoteWeb.QuoteController do
  use BlockquoteWeb, :controller

  alias Blockquote.Admin
  alias Blockquote.Admin.Quote
  alias Blockquote.Repo
  
  def related_fields do
    #need to add empty value at start of authors since it is optional
    authors = Admin.list_authors() |> BlockquoteWeb.AuthorView.map_for_form |> List.insert_at(0, {"", nil})
    categories = Admin.list_categories() |> BlockquoteWeb.CategoryView.map_for_form
    sources = Admin.list_sources() |> BlockquoteWeb.SourceView.map_for_form
    [authors: authors, categories: categories, sources: sources]
  end

  def index(conn, _params) do
    quotes = Admin.list_quotes()
    render(conn, BlockquoteWeb.SharedView, "index.html", items: quotes, item_view: view_module(conn), item_name_singular: "quote", item_display_func: :to_excerpt)
  end

  def new(conn, params) do
    changeset = Admin.change_quote(%Quote{})
    new_page(conn, changeset, params)
  end
  
  def new_page(conn, changeset, _params) do
    render(conn, "new.html", changeset: changeset, related_fields: related_fields())
  end
  
  def edit_page(conn, changeset, quote) do
    render(conn, "edit.html", changeset: changeset, related_fields: related_fields(), item: quote)
  end

  def create(conn, %{"quote" => quote_params}) do
    changeset = Admin.create_quote_changeset(quote_params)
    source_id = Ecto.Changeset.get_field(changeset, :source_id)
    source = Admin.get_source!(source_id)
    
    case Repo.insert(Quote.validate_author_id(changeset, source)) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote created successfully.")
        |> redirect(to: quote_path(conn, :show, quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        new_page(conn, changeset, nil)
    end
  end

  def show(conn, %{"id" => id}) do
    quote = Admin.get_quote_for_show!(id)
    render(conn, "show.html", quote: quote)
  end

  def edit(conn, %{"id" => id}) do
    quote = Admin.get_quote!(id)
    changeset = Admin.change_quote(quote)
    edit_page(conn, changeset, quote)
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Admin.get_quote!(id)
    
    changeset = Admin.update_quote_changeset(quote, quote_params)
    source_id = Ecto.Changeset.get_field(changeset, :source_id)
    source = Admin.get_source!(source_id)

    case Repo.update(Quote.validate_author_id(changeset, source)) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: quote_path(conn, :show, quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        edit_page(conn, changeset, quote)
    end
  end

  def delete(conn, %{"id" => id}) do
    quote = Admin.get_quote!(id)
    {:ok, _quote} = Admin.delete_quote(quote)

    conn
    |> put_flash(:info, "Quote deleted successfully.")
    |> redirect(to: quote_path(conn, :index))
  end
end

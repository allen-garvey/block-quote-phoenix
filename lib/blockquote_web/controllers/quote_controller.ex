defmodule BlockquoteWeb.QuoteController do
  use BlockquoteWeb, :controller

  alias Blockquote.Admin
  alias Blockquote.Admin.Quote
  
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

  def create(conn, %{"quote" => quote_params}) do
    case Admin.create_quote(quote_params) do
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
    render(conn, "edit.html", quote: quote, changeset: changeset, related_fields: related_fields())
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Admin.get_quote!(id)

    case Admin.update_quote(quote, quote_params) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: quote_path(conn, :show, quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quote: quote, changeset: changeset, related_fields: related_fields())
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

defmodule BlockquoteWeb.QuoteController do
  use BlockquoteWeb, :controller

  alias Blockquote.Admin
  alias Blockquote.Admin.Quote

  def index(conn, _params) do
    quotes = Admin.list_quotes()
    render(conn, "index.html", quotes: quotes)
  end

  def new(conn, _params) do
    changeset = Admin.change_quote(%Quote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quote" => quote_params}) do
    case Admin.create_quote(quote_params) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote created successfully.")
        |> redirect(to: quote_path(conn, :show, quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quote = Admin.get_quote!(id)
    render(conn, "show.html", quote: quote)
  end

  def edit(conn, %{"id" => id}) do
    quote = Admin.get_quote!(id)
    changeset = Admin.change_quote(quote)
    render(conn, "edit.html", quote: quote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Admin.get_quote!(id)

    case Admin.update_quote(quote, quote_params) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: quote_path(conn, :show, quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quote: quote, changeset: changeset)
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

defmodule BlockquoteWeb.DailyQuoteController do
  use BlockquoteWeb, :controller

  alias Blockquote.Admin
  alias Blockquote.Admin.DailyQuote
  
  def related_fields do
    quotes = Admin.list_quotes() |> BlockquoteWeb.QuoteView.map_for_form
    [quotes: quotes]
  end

  def index(conn, _params) do
    daily_quotes = Admin.list_daily_quotes_for_index()
    render(conn, BlockquoteWeb.SharedView, "index.html", items: daily_quotes, item_view: view_module(conn), item_name_singular: "daily quote", item_display_func: :to_s)
  end
  
  def new_page(conn, changeset, _params) do
    render(conn, "new.html", changeset: changeset, related_fields: related_fields())
  end
  
  def edit_page(conn, changeset, daily_quote) do
    render(conn, "edit.html", changeset: changeset, related_fields: related_fields(), item: daily_quote)
  end

  def new(conn, params) do
    changeset = Admin.change_daily_quote(%DailyQuote{})
    new_page(conn, changeset, params)
  end

  def create(conn, %{"daily_quote" => daily_quote_params}) do
    case Admin.create_daily_quote(daily_quote_params) do
      {:ok, daily_quote} ->
        conn
        |> put_flash(:info, "Daily quote created successfully.")
        |> redirect(to: daily_quote_path(conn, :show, daily_quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        new_page(conn, changeset, nil)
    end
  end

  def show(conn, %{"id" => id}) do
    daily_quote = Admin.get_daily_quote_for_show!(id)
    render(conn, "show.html", daily_quote: daily_quote)
  end

  def edit(conn, %{"id" => id}) do
    daily_quote = Admin.get_daily_quote!(id)
    changeset = Admin.change_daily_quote(daily_quote)
    edit_page(conn, changeset, daily_quote)
  end

  def update(conn, %{"id" => id, "daily_quote" => daily_quote_params}) do
    daily_quote = Admin.get_daily_quote!(id)

    case Admin.update_daily_quote(daily_quote, daily_quote_params) do
      {:ok, daily_quote} ->
        conn
        |> put_flash(:info, "Daily quote updated successfully.")
        |> redirect(to: daily_quote_path(conn, :show, daily_quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        edit_page(conn, changeset, daily_quote)
    end
  end

  def delete(conn, %{"id" => id}) do
    daily_quote = Admin.get_daily_quote!(id)
    {:ok, _daily_quote} = Admin.delete_daily_quote(daily_quote)

    conn
    |> put_flash(:info, "Daily quote deleted successfully.")
    |> redirect(to: daily_quote_path(conn, :index))
  end
end

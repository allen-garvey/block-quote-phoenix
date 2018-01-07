defmodule BlockquoteWeb.DailyQuoteController do
  use BlockquoteWeb, :controller

  alias Blockquote.Admin
  alias Blockquote.Admin.DailyQuote

  def index(conn, _params) do
    daily_quotes = Admin.list_daily_quotes()
    render(conn, "index.html", daily_quotes: daily_quotes)
  end

  def new(conn, _params) do
    changeset = Admin.change_daily_quote(%DailyQuote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"daily_quote" => daily_quote_params}) do
    case Admin.create_daily_quote(daily_quote_params) do
      {:ok, daily_quote} ->
        conn
        |> put_flash(:info, "Daily quote created successfully.")
        |> redirect(to: daily_quote_path(conn, :show, daily_quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    daily_quote = Admin.get_daily_quote!(id)
    render(conn, "show.html", daily_quote: daily_quote)
  end

  def edit(conn, %{"id" => id}) do
    daily_quote = Admin.get_daily_quote!(id)
    changeset = Admin.change_daily_quote(daily_quote)
    render(conn, "edit.html", daily_quote: daily_quote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "daily_quote" => daily_quote_params}) do
    daily_quote = Admin.get_daily_quote!(id)

    case Admin.update_daily_quote(daily_quote, daily_quote_params) do
      {:ok, daily_quote} ->
        conn
        |> put_flash(:info, "Daily quote updated successfully.")
        |> redirect(to: daily_quote_path(conn, :show, daily_quote))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", daily_quote: daily_quote, changeset: changeset)
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

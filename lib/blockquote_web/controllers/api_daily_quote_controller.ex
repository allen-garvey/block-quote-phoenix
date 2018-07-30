defmodule BlockquoteWeb.ApiDailyQuoteController do
  use BlockquoteWeb, :controller

  alias Blockquote.Api
  alias Blockquote.Admin.DailyQuote

  def get_daily_quote(conn, _params) do
    daily_quote = Api.get_random_daily_quote!()
    render(conn, "show.json", daily_quote: daily_quote)
  end
end

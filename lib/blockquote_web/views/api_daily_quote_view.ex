defmodule BlockquoteWeb.ApiDailyQuoteView do
  use BlockquoteWeb, :view

  def render("show.json", %{daily_quote: daily_quote}) do
    %{data: render_one(daily_quote, __MODULE__, "daily_quote.json", as: :daily_quote)}
  end

  def render("daily_quote.json", %{daily_quote: daily_quote}) do
  	quote = daily_quote.quote
  	quote_author = author_for_quote(quote.author, quote.source.author)
    %{
    	id: quote.id,
    	body: quote.body,
    	source: %{
    		title: quote.source.title,
    		parent_title: parent_source_title(quote.source.parent_source),
    	},
    	category: quote.category.name,
    	author: %{
    		first_name: quote_author.first_name,
    		middle_name: quote_author.middle_name,
    		last_name: quote_author.last_name,
    	},
	}
  end

  #returns the author for a quote
  #because a quote author might be nil, but the source author should never be nil
  def author_for_quote(nil, source_author) do
  	source_author
  end
  def author_for_quote(quote_author, _source_author) do 
  	quote_author
  end

  def parent_source_title(nil) do
  	nil
  end
  def parent_source_title(parent_source) do
  	parent_source.title
  end
end
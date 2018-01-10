defmodule BlockquoteWeb.QuoteView do
  use BlockquoteWeb, :view
  
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, shared_form_assigns(assigns))
    render BlockquoteWeb.SharedView, "new.html", assigns
  end

  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, 
      %{
        item_display_name: "Quote"
      }
    ) |> Map.merge(shared_form_assigns(assigns))
    render BlockquoteWeb.SharedView, "edit.html", assigns
  end

  def shared_form_assigns(assigns) do
    %{
        item_name_singular: "quote",
        required_fields: Blockquote.Admin.Quote.required_fields(), 
        form_fields: form_fields(assigns[:related_fields])
      }
  end
  
  def to_excerpt(quote) do
    if String.length(quote.body) > 120 do
        quote.body |> String.slice(0, 130) |> Kernel.<>("...")
    else
        quote.body
    end
  end
  
  def quote_author(quote) do
    if !is_nil(quote.author) do
      quote.author
    else
      quote.source.author
    end
  end
  
  def item_columns(conn, quote) do
    author = quote_author(quote)
    author_link = link(BlockquoteWeb.AuthorView.to_s(author), to: author_path(conn, :show, author))
    category_link = link(BlockquoteWeb.CategoryView.to_s(quote.category), to: category_path(conn, :show, quote.category))
    source_link = link(BlockquoteWeb.SourceView.to_s(quote.source), to: source_path(conn, :show, quote.source))
    
    [
      {"body", quote.body}, 
      {"author", author_link}, 
      {"category", category_link},
      {"source", source_link},
      {"added", BlockquoteWeb.SharedView.item_date_created(quote)},
    ]
  end
  
  def form_fields(related_fields) do
    [
      {:body, :text, nil},
      {:category_id, :select, related_fields[:categories]},
      {:author_id, :select, related_fields[:authors]},
      {:source_id, :select, related_fields[:sources]},
    ]
  end
end

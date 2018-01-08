defmodule BlockquoteWeb.QuoteView do
  use BlockquoteWeb, :view
  
  def to_excerpt(quote) do
    if String.length(quote.body) > 120 do
        quote.body |> String.slice(0, 130) |> Kernel.<>("...")
    else
        quote.body
    end
  end
end

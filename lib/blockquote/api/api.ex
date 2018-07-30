defmodule Blockquote.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias Blockquote.Repo

  alias Blockquote.Admin.DailyQuote

  @doc """
  Gets a single random daily_quote.

  Raises `Ecto.NoResultsError` if the Daily quote table is empty

  """
  def get_random_daily_quote!() do 
    Repo.one!(from(DailyQuote, order_by: fragment("random()"), limit: 1))
      # preload the quote, author from quote, source from quote, and author from quote source
      |> Repo.preload([ {:quote, [:author, :category, {:source, [:author, :parent_source]}]} ])
  end

end

defmodule Blockquote.Admin.Quote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blockquote.Admin.Quote


  schema "quotes" do
    field :body, :string
    field :author_id, :id
    field :category_id, :id
    field :source_id, :id

    timestamps()
    
    has_many :daily_quotes, Blockquote.Admin.DailyQuote
  end

  @doc false
  def changeset(%Quote{} = quote, attrs) do
    quote
    |> cast(attrs, [:body, :author_id, :category_id, :source_id])
    |> validate_required([:body, :source_id, :category_id])
    |> foreign_key_constraint(:author_id)
    |> assoc_constraint(:author)
    |> foreign_key_constraint(:source_id)
    |> assoc_constraint(:source)
    |> foreign_key_constraint(:category_id)
    |> assoc_constraint(:category)
  end
end

defmodule Blockquote.Admin.Quote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blockquote.Admin.Quote


  schema "quotes" do
    field :body, :string

    timestamps()
    
    belongs_to :category, Blockquote.Admin.Category
    belongs_to :author, Blockquote.Admin.Author
    belongs_to :source, Blockquote.Admin.Source
    
    has_many :daily_quotes, Blockquote.Admin.DailyQuote
  end
  
  def required_fields() do
    [:body, :source_id, :category_id]
  end

  @doc false
  def changeset(%Quote{} = quote, attrs) do
    quote
    |> cast(attrs, [:body, :author_id, :category_id, :source_id])
    |> validate_required(required_fields())
    |> foreign_key_constraint(:author_id)
    |> assoc_constraint(:author)
    |> foreign_key_constraint(:source_id)
    |> assoc_constraint(:source)
    |> foreign_key_constraint(:category_id)
    |> assoc_constraint(:category)
  end
end

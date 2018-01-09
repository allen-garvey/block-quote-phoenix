defmodule Blockquote.Admin.Source do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blockquote.Admin.Source


  schema "sources" do
    field :subtitle, :string
    field :title, :string
    field :url, :string

    timestamps()
    
    has_many :quotes, Blockquote.Admin.Quote
    belongs_to :source_type, Blockquote.Admin.SourceType
    belongs_to :author, Blockquote.Admin.Author
    belongs_to :parent_source, Blockquote.Admin.ParentSource
  end
  
  def required_fields() do
    [:title, :author_id, :source_type_id]
  end

  @doc false
  def changeset(%Source{} = source, attrs) do
    source
    |> cast(attrs, [:title, :subtitle, :url, :author_id, :source_type_id, :parent_source_id])
    |> validate_required(required_fields())
    |> foreign_key_constraint(:source_type_id)
    |> assoc_constraint(:source_type)
    |> foreign_key_constraint(:author_id)
    |> assoc_constraint(:author)
    |> foreign_key_constraint(:parent_source_id)
    |> assoc_constraint(:parent_source)
  end
end

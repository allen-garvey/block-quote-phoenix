defmodule Blockquote.Admin.Source do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blockquote.Admin.Source


  schema "sources" do
    field :subtitle, :string
    field :title, :string
    field :url, :string
    field :author_id, :id
    field :source_type_id, :id
    field :parent_source_id, :id

    timestamps()
    
    has_many :quotes, Blockquote.Admin.Quote
  end

  @doc false
  def changeset(%Source{} = source, attrs) do
    source
    |> cast(attrs, [:title, :subtitle, :url, :author_id, :source_type_id, :parent_source_id])
    |> validate_required([:title, :author_id, :source_type_id])
    |> foreign_key_constraint(:source_type_id)
    |> assoc_constraint(:source_type)
    |> foreign_key_constraint(:author_id)
    |> assoc_constraint(:author)
    |> foreign_key_constraint(:parent_source_id)
    |> assoc_constraint(:parent_source)
  end
end

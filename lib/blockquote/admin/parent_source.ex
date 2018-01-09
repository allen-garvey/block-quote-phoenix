defmodule Blockquote.Admin.ParentSource do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blockquote.Admin.ParentSource


  schema "parent_sources" do
    field :subtitle, :string
    field :title, :string
    field :url, :string
    
    timestamps()
    
    has_many :sources, Blockquote.Admin.Source
    belongs_to :source_type, Blockquote.Admin.SourceType
  end
  
  def required_fields() do
    [:title, :source_type_id]
  end

  @doc false
  def changeset(%ParentSource{} = parent_source, attrs) do
    parent_source
    |> cast(attrs, [:title, :subtitle, :url, :source_type_id])
    |> validate_required(required_fields())
    |> foreign_key_constraint(:source_type_id)
    |> assoc_constraint(:source_type)
  end
end

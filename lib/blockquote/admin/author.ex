defmodule Blockquote.Admin.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blockquote.Admin.Author


  schema "authors" do
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string

    timestamps()
    
    has_many :quotes, Blockquote.Admin.Quote
  end

  @doc false
  def changeset(%Author{} = author, attrs) do
    author
    |> cast(attrs, [:first_name, :middle_name, :last_name])
    |> validate_required([:first_name])
    |> unique_constraint(:first_name, name: :author_unique_name_index)
    |> unique_constraint(:middle_name, name: :author_unique_name_index)
    |> unique_constraint(:last_name, name: :author_unique_name_index)
  end
end

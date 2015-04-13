class AddCasesToNouns < ActiveRecord::Migration
  def change
    add_column :nouns, :partitive, :string
    add_column :nouns, :locative, :string
    add_column :nouns, :plural_partitive, :string
    add_column :nouns, :plural_locative, :string
  end
end

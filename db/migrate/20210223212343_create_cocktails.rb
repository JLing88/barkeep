class CreateCocktails < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails do |t|
      execute "create extension hstore"
      t.hstore :recipe
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end

class AddResultsToSearch < ActiveRecord::Migration[5.2]
  def change
    execute "create extension hstore"
    add_column :searches, :results, :hstore
  end
end

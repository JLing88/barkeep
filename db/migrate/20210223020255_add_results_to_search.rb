class AddResultsToSearch < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :results, :jsonb
    add_index  :searches, :results, using: :gin
  end
end

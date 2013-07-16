class AddColumnsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :city,   :string
    add_column :searches, :result, :text
  end
end

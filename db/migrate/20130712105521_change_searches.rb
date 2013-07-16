class ChangeSearches < ActiveRecord::Migration
  def change
    add_column    :searches, :min_temp, :integer
    add_column    :searches, :max_temp, :integer
    add_column    :searches, :weather,   :integer
    remove_column :searches, :result
  end
end

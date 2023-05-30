class AddCounterToUrlEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :url_entries, :counter, :integer, default: 0
  end
end

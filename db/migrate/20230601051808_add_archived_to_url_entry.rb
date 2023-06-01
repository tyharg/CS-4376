class AddArchivedToUrlEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :url_entries, :archived, :boolean, default: false
  end
end

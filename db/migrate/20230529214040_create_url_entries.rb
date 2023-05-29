class CreateUrlEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :url_entries do |t|
      t.string :url
      t.string :description
      t.datetime :expire

      t.timestamps
    end
  end
end

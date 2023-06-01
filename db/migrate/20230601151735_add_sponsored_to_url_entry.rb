class AddSponsoredToUrlEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :url_entries, :sponsored, :boolean, default:false
  end
end

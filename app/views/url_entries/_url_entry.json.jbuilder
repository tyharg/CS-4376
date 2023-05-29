json.extract! url_entry, :id, :url, :description, :expire, :created_at, :updated_at
json.url url_entry_url(url_entry, format: :json)

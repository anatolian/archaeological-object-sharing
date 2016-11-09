json.extract! location, :id, :name, :description, :coordinate, :created_at, :updated_at
json.url location_url(location, format: :json)
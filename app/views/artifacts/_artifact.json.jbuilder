json.extract! artifact, :id, :name, :description, :longitude, :latitude, :filepath, :file, :model, :created_at, :updated_at
json.url artifact_url(artifact, format: :json)

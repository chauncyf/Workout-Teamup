json.extract! user_location, :id, :user_id, :latitude, :longitude, :status, :created_at, :updated_at
json.url user_location_url(user_location, format: :json)

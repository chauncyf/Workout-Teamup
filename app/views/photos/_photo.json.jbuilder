json.extract! photo, :id, :activity_id, :user_id, :photo_url, :created_at, :updated_at
json.url photo_url(photo, format: :json)

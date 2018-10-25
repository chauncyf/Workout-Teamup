json.extract! follow, :id, :followee_id, :follower_id, :created_at, :updated_at
json.url follow_url(follow, format: :json)

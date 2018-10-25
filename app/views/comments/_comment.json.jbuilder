json.extract! comment, :id, :activity_id, :user_id, :content, :type, :created_at, :updated_at
json.url comment_url(comment, format: :json)

json.extract! user, :id, :user_name, :email, :potrait_url, :height, :weight, :physical_condition, :motto, :created_at, :updated_at
json.url user_url(user, format: :json)

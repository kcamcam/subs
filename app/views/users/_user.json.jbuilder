json.extract! user, :id, :uid, :enabled, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)

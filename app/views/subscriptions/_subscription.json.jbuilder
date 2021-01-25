json.extract! subscription, :id, :brand_id, :user_id, :amount, :frequency, :unit, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)

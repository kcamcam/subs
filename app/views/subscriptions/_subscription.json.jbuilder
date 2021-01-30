json.extract! subscription, :id, :brand_id, :user_id, :amount, :frequency, :units, :created_at, :updated_at,
              :enabled, :first_bill
json.url subscription_url(subscription, format: :json)

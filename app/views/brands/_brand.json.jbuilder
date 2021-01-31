json.extract! brand, :id, :image, :name, :info, :category, :url, :created_at, :updated_at,
              :created_by, :custom, :released_at, :released_by
json.url brand_url(brand, format: :json)

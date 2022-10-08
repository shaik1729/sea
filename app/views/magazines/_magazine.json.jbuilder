json.extract! magazine, :id, :title, :url, :created_at, :updated_at
json.url magazine_url(magazine, format: :json)

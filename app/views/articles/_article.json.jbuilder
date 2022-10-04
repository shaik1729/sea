json.extract! article, :id, :title, :keywords, :approval_status, :reviewer1_id, :reviewer2_id, :reviewer3_id, :created_at, :updated_at
json.url article_url(article, format: :json)

json.extract! document, :id, :title, :keywords, :approved_status, :reviewer1_id, :reviewer2_id, :reviewer3_id, :created_at, :updated_at
json.url document_url(document, format: :json)

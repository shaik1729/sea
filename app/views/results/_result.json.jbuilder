json.extract! result, :id, :subject_title, :internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :result_type, :user_id, :semester_id, :last_updated_user_id, :created_at, :updated_at
json.url result_url(result, format: :json)

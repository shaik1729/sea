json.extract! notification, :id, :title, :user_id, :regulation_id, :batch_id, :department_id, :course_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)

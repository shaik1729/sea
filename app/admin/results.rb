ActiveAdmin.register Result do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :subject_title, :internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :result_type, :user_id, :semester_id, :last_updated_user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:subject_title, :internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :result_type, :user_id, :department_id, :batch_id, :regulation_id, :semester_id, :last_updated_user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

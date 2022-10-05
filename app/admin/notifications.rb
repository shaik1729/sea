ActiveAdmin.register Notification do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :content, :user_id, :regulation_id, :batch_id, :department_id, :course_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :user_id, :regulation_id, :batch_id, :department_id, :course_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
    form do |f|
      f.inputs "Notification" do
        f.input :title
        f.rich_text_area :content
        f.input :user
        f.input :regulation
        f.input :batch
        f.input :department
        f.input :course
      end
      f.actions
    end

    after_create do |notification|
      NotificationMailer.with(title: notification.title, regulation_id: notification.regulation&.id, user_id: notification.user&.id, batch_id: notification.batch&.id, department_id: notification.department&.id, course_id: notification.course&.id).new_notification.deliver_later
    end
end
ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :name, :mobile, :rollno, :role_id, :department_id, :course_id, :regulation_id, :batch_id, :password, :password_confirmation, :avatar_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :name, :mobile, :rollno, :role_id, :department_id, :course_id, :regulation_id, :batch_id, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  action_item :only => :index do
    link_to 'Create Users via Upload CSV', :action => 'create_users'
  end

  collection_action :create_users do
    render "admin/csv/create_users"
  end

  collection_action :import_csv, :method => :post do
    CreateUsersViaCsv.convert_save("user", params[:dump][:file])
    redirect_to :action => :index, :notice => "Users Created successfully!"
  end

  form do |f|
      f.inputs "User" do
        f.input :email
        f.input :name
        f.input :rollno
        f.input :password
        f.input :password_confirmation
        f.input :role      
        f.input :mobile
        f.input :department
        f.input :course
        f.input :regulation
        f.input :batch
        f.input :avatar_url
      end
      f.actions
    end

    index do
      selectable_column
      column :email
      column :name
      column :role
      column :mobile
      column :department
      column :rollno
      actions
    end

end

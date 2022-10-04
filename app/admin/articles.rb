ActiveAdmin.register Article do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :keywords, :approval_status, :reviewer1_id, :reviewer2_id, :reviewer3_id, :content, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :keywords, :approval_status, :reviewer1_id, :reviewer2_id, :reviewer3_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
      f.inputs "Article" do
        f.input :title
        f.input :keywords
        f.rich_text_area :content
        f.input :user
      end
      f.actions
    end

    index do
      selectable_column
      column :title
      column :keywords
      column :approval_status
      column :user
      actions
    end

end

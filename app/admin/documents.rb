ActiveAdmin.register Document do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :keywords, :content, :approved_status, :reviewer1_id, :reviewer2_id, :reviewer3_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :keywords, :approved_status, :reviewer1_id, :reviewer2_id, :reviewer3_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

    form do |f|
      f.inputs "Document" do
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
      column :approved_status
      column :user
      actions
    end

end

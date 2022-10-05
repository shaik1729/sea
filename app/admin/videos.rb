ActiveAdmin.register Video do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :tutorial_id, :content, :clip, :thumbnail, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :tutorial_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

    form do |f|
      f.inputs "Video" do
        f.input :title 
        f.rich_text_area :content
        f.input :clip, as: :file
        f.input :thumbnail, as: :file
        f.input :tutorial
      end
      f.actions
    end


  show do
    attributes_table do
      row :title
      row :content do
        div resource.content
      end
    end
  end
end
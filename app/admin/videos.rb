ActiveAdmin.register Video do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :tutorial_id, :content, :user_id, :terabox_video_url
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
        f.input :tutorial
        f.input :user
      end
      f.actions
    end


  show do
    attributes_table do
      row :title
      row :tutorial
      row :user
      row :content do
        div resource.content
      end
    end
  end
end

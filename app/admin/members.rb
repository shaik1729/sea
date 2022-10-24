ActiveAdmin.register Member do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :designation, :image, :content
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :designation]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs "Member" do
      f.input :name 
      f.input :designation
      f.rich_text_area :content
      f.input :image, as: :file
    end
    f.actions
  end
  
end

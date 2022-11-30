ActiveAdmin.register Department do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :code, :vision, :mission, :logo
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :code]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


    form do |f|
      f.inputs "Department" do
        f.input :name 
        f.input :code
        f.input :vision
        f.input :mission
        f.input :logo, as: :file
      end
      f.actions
    end
  
end

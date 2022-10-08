ActiveAdmin.register Magazine do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :url
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  after_create do |magazine|
    MagazineMailer.with(title: magazine.title, url: magazine.url).new_magazine.deliver_later
  end

end

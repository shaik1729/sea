class HomeController < ApplicationController
  def index
  end

  def search
    params[:title].upcase!
    @articles = Article.where("approval_status = ? and title like ?", Article::APPROVED, "%#{params[:title]}%").order("id DESC").limit(10)
    @documents = Document.where("approval_status = ? and title like ?", Document::APPROVED, "%#{params[:title]}%").order("id DESC").limit(10)
    @magazines = Magazine.where("title like '%#{params[:title]}%'").order("id DESC").limit(10)
    @notifications = Notification.where("title like '%#{params[:title]}%'").order("id DESC").limit(10)
    @tutorials = Tutorial.where("title like '%#{params[:title]}%'").order("id DESC").limit(10)
  end
end

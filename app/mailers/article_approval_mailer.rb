class ArticleApprovalMailer < ApplicationMailer
    def approval_status
        @article = params[:article]
        @status = params[:status]
        @user = params[:user]
        @message = params[:message]
        mail(to: @article.user.email, subject: "Status of ID : D#{@article.id}")
    end
end

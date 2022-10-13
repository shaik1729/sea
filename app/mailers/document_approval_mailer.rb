class DocumentApprovalMailer < ApplicationMailer
    def approval_status
        @document = params[:document]
        @status = params[:status]
        @user = params[:user]
        @message = params[:message]
        mail(to: @document.user.email, subject: "Status of ID : D#{@document.id}")
    end
end

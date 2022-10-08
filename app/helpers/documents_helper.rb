module DocumentsHelper
    def show_document_approve_button?
       (current_user.role.code != "STU") && (@document.approval_status == Document::IN_REVIEW) && !([@document.reviewer1, @document.reviewer2, @document.reviewer3].include? current_user)
    end

    def show_document_comments?
        @document.approval_status == Document::APPROVED
    end

    def show_document_approval_status?
        @document.user == current_user && current_user.role.code == "STU"
    end
end

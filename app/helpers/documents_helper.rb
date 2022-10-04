module DocumentsHelper
    def show_approve_button?
       (current_user.role.code != "STU") && (@document.approval_status == Document::IN_REVIEW) && !([@document.reviewer1, @document.reviewer2, @document.reviewer3].include? current_user)
    end
end

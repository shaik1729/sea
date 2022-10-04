module ArticlesHelper
    def show_article_approve_button?
       (current_user.role.code != "STU") && (@article.approval_status == Article::IN_REVIEW) && !([@article.reviewer1, @article.reviewer2, @article.reviewer3].include? current_user)
    end
end

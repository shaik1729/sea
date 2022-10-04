class MagazineMailer < ApplicationMailer
    def new_magazine
        @title = params[:title]
        @url = params[:url]
        mail(to: User.all.map(&:email).join(';'), subject: "Check Out SVIT New Magazine!!!")
    end
end

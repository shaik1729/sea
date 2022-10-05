class WelcomeMailer < ApplicationMailer
    def welcome_user
        @name = params[:name]
        @email = params[:email]
        mail(to: @email, subject: "Your Account for SVIT member has been created successfully!!")
    end
end

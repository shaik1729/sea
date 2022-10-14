class WelcomeMailer < ApplicationMailer
    def welcome_user
        @name = params[:name]
        @email = params[:email]
        @password = params[:password]
        mail(to: @email, subject: "Your Account for SEA(SVIT EDU AMP) has been created successfully!!")
    end
end

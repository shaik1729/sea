class NotificationMailer < ApplicationMailer
    def new_notification
        @title = params[:title]
        @regulation_id = params[:regulation_id]
        @user_id = params[:user_id]
        @batch_id = params[:batch_id]
        @department_id = params[:department_id]
        @course_id = params[:course_id]
        @from = params[:from]
        @url = params[:url]

        if @department_id.nil? && @regulation_id.nil? && @batch_id.nil? && @course_id.nil?
            mail(to: User.all.map(&:email).join(';'), subject: "#{@title}")
        elsif ((!@department_id.nil? && !@regulation_id.nil?) && (@batch_id.nil? && @course_id.nil?))
            mail(to: User.where("department_id = ? AND regulation_id = ?", @department_id, @regulation_id).map(&:email).join(';'), subject: "#{@title}")
        elsif ((!@department_id.nil? && !@batch_id.nil?) && (@regulation_id.nil? && @course_id.nil?))
            mail(to: User.where("department_id = ? AND batch_id = ?", @department_id, @batch_id).map(&:email).join(';'), subject: "#{@title}")
        elsif ((!@regulation_id.nil? && !@course_id.nil?) && (@department_id.nil? && @batch_id.nil?))
            mail(to: User.where("regulation_id = ? AND course_id = ?", @regulation_id, @course_id).map(&:email).join(';'), subject: "#{@title}")
        elsif ((!@department_id.nil? && !@regulation_id.nil?) && (@batch_id.nil? && @course_id.nil?))
            mail(to: User.where("department_id = ? AND regulation_id = ?", @department_id, @regulation_id).map(&:email).join(';'), subject: "#{@title}")
        elsif (!@department_id.nil? && (@regulation_id.nil? && @batch_id.nil? && @course_id.nil?))
            mail(to: User.where("department_id = ?", @department_id).map(&:email).join(';'), subject: "#{@title}")
        elsif ((@department_id.nil? && @regulation_id.nil?) && (!@batch_id.nil? && !@course_id.nil?))
            mail(to: User.where("batch_id = ? AND course_id = ?", @batch_id, @course_id).map(&:email).join(';'), subject: "#{@title}")
        elsif (!@regulation_id.nil? && (@department_id.nil? && @batch_id.nil? && @course_id.nil?))
            mail(to: User.where("regulation_id = ?", @regulation_id).map(&:email).join(';'), subject: "#{@title}")
        elsif (!@batch_id.nil? && (@department_id.nil? && @regulation_id.nil? && @course_id.nil?))
            mail(to: User.where("batch_id = ?", @batch_id).map(&:email).join(';'), subject: "#{@title}")
        elsif (!@course_id.nil? && (@department_id.nil? && @regulation_id.nil? && @batch_id.nil?))
            mail(to: User.where("course_id = ?", @course_id).map(&:email).join(';'), subject: "#{@title}")
        else
            mail(to: User.where("department_id = ? AND course_id = ? AND regulation_id = ? AND batch_id = ?",@department_id, @course_id, @regulation_id, @batch_id).map(&:email).join(';'), subject: "New notification '#{@title}'")
        end
    end
end

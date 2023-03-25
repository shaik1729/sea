class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[ show edit update destroy ]
  before_action :authrize_access

  # GET /notifications or /notifications.json
  def index
    @notifications = Notification.all.order("id DESC")
    if !current_user.is_student?
      @your_notifications = current_user.notifications.all.order("id DESC")
    end
  end

  # GET /notifications/1 or /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications or /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        @from = "#{current_user.name} (#{current_user.role.name} - #{current_user.department.name})"

        NotificationMailer.with(title: @notification.title, regulation_id: @notification.regulation&.id, user_id: @notification.user&.id, batch_id: @notification.batch&.id, department_id: @notification.department&.id, course_id: @notification.course&.id, from: @from, url: notification_url(@notification)).new_notification.deliver_later

        format.html { redirect_to notification_url(@notification), notice: "Notification was successfully created." }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1 or /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to notification_url(@notification), notice: "Notification was successfully updated." }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1 or /notifications/1.json
  def destroy
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url, notice: "Notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def authrize_access
      if current_user.is_student?
        raise 'Unauthorized' unless ['index', 'show'].include?(params[:action])
      else
        if ['edit', 'update', 'destroy'].include?(params[:action])
          raise 'Unauthorized' unless @notification.user == current_user
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:title, :content, :user_id, :regulation_id, :batch_id, :department_id, :course_id)
    end
end

class TutorialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tutorial, only: %i[ show edit update destroy ]
  before_action :authrize_access

  # GET /tutorials or /tutorials.json
  def index
    if current_user.is_hod?
      @your_tutorials = current_user.tutorials.all.order("id DESC")
    else
      @your_tutorials = []
    end
    @tutorials = Tutorial.all.order("id DESC")    
  end

  # GET /tutorials/1 or /tutorials/1.json
  def show
    @videos = @tutorial.videos.all
    @qrcodes = []
    
    @videos.each do |video|

      if video.terabox_video_url.present?
        begin
          url = URI("https://api.qrcode-monkey.com/qr/custom")
          https = Net::HTTP.new(url.host, url.port)
          https.use_ssl = true
          request = Net::HTTP::Post.new(url)
          request["Content-Type"] = "text/plain"
          request.body = {"data":"#{video.terabox_video_url}","config":{"body":"circle-zebra-vertical","eye":"frame13","eyeBall":"ball15","erf1":[],"erf2":[],"erf3":[],"brf1":[],"brf2":[],"brf3":[],"bodyColor":"#0277BD","bgColor":"#FFFFFF","eye1Color":"#075685","eye2Color":"#075685","eye3Color":"#075685","eyeBall1Color":"#0277BD","eyeBall2Color":"#0277BD","eyeBall3Color":"#0277BD","gradientColor1":"#075685","gradientColor2":"#0277BD","gradientType":"linear","gradientOnEyes":false,"logo":"https://raw.githubusercontent.com/shaik1729/sea/development/app/assets/images/sea_logo.jpeg","logoMode":"default"},"size":300,"download":false,"file":"png"}.to_json
          response = https.request(request)
          @qrcodes << Base64.strict_encode64(response.read_body)
        rescue => exception
          puts "*************************************#{exception}**************************"
          @qrcode << nil
        end
      else
        @qrcode << nil
      end
    end

  end

  # GET /tutorials/new
  def new
    @tutorial = Tutorial.new
  end

  # GET /tutorials/1/edit
  def edit
  end

  # POST /tutorials or /tutorials.json
  def create
    @tutorial = Tutorial.new(tutorial_params)

    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to tutorials_path, notice: "Tutorial was successfully created." }
        format.json { render :show, status: :created, location: @tutorial }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutorials/1 or /tutorials/1.json
  def update
    respond_to do |format|
      if @tutorial.update(tutorial_params)
        format.html { redirect_to tutorials_path, notice: "Tutorial was successfully updated." }
        format.json { render :show, status: :ok, location: @tutorial }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutorials/1 or /tutorials/1.json
  def destroy
    @tutorial.destroy

    respond_to do |format|
      format.html { redirect_to tutorials_url, notice: "Tutorial was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    def authrize_access
      if current_user.is_student? || current_user.is_faculty?
        raise 'Unauthorized' unless (['index', 'show'].include?(params[:action]))
      else
        if ['edit', 'update', 'destroy'].include?(params[:action])
          raise 'Unauthorized' unless @tutorial.user == current_user
        elsif ['create', 'new'].include?(params[:action])
          raise 'Unauthorized' unless current_user.is_hod?
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def tutorial_params
      params.require(:tutorial).permit(:title, :user_id)
    end
end

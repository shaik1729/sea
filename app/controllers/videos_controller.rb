class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: %i[ show edit update destroy ]
  before_action :authrize_access

  # GET /videos or /videos.json
  def index
    @your_videos = current_user.videos.all.order("id DESC")
  end

  # GET /videos/1 or /videos/1.json
  def show
    link = @video.video_url.split("=")[1]
    @iframe_url = "https://www.youtube.com/embed/#{link}"
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos or /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to videos_path, notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    def authrize_access
      if current_user.is_student? || current_user.is_faculty?
        raise 'Unauthorized' if (['index', 'show', 'edit', 'update', 'destroy','create', 'new'].include?(params[:action]))
      else
        if ['edit', 'update', 'destroy'].include?(params[:action])
          raise 'Unauthorized' unless @video.tutorial.user == current_user
        elsif ['create', 'new'].include?(params[:action])
          raise 'Unauthorized' unless current_user.is_hod?
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :content, :tutorial_id, :user_id, :video_url)
    end
end

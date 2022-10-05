class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result, only: %i[ show edit update destroy ]
  before_action :authrize_access

  # GET /results or /results.json
  def index
    if params[:search].present?
      @user = User.find_by(rollno: params[:search].upcase)
      if !@user.nil?
        @results = Result.where(user_id: @user.id)
        if @results.empty?
          redirect_to results_path, notice: "Roll number doesn't have any resutls yet"
        else
          @total_credits = Result.where(user_id: @user.id).sum(:credits)
        end
      else
        redirect_to results_path, notice: "Roll number doesn't exist"
      end
    else
      @results = []
    end
  end

  # GET /results/1 or /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results or /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to result_url(@result), notice: "Result was successfully created." }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1 or /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to result_url(@result), notice: "Result was successfully updated." }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1 or /results/1.json
  def destroy
    @result.destroy

    respond_to do |format|
      format.html { redirect_to results_url, notice: "Result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    Result.import(params[:file])
    redirect_to results_path, notice: "Results Uploaded Successfully"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    def authrize_access
      if current_user.is_student? || current_user.is_faculty?
        raise 'Unauthorized' unless (['index', 'show'].include?(params[:action]))
      end
    end

    # Only allow a list of trusted parameters through.
    def result_params
      params.require(:result).permit(:subject_title, :internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :result_type, :user_id, :semester_id, :last_updated_user_id)
    end
end

class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[ show edit update destroy approve reject]
  before_action :authrize_access


  # GET /articles or /articles.json
  def index
    @articles = current_user.articles.all.order("id DESC")
    if !current_user.is_student?
      @review_arts = Article.where("approval_status = :in_review AND (reviewer1_id IS NULL OR reviewer1_id != :user_id ) AND (reviewer2_id IS NULL OR reviewer2_id != :user_id) AND (reviewer3_id IS NULL OR reviewer3_id != :user_id)", {in_review: Article::IN_REVIEW, user_id: current_user.id}).order("id DESC")
      @approved_articles = Article.where("reviewer1_id = :user_id OR reviewer2_id = :user_id OR reviewer3_id = :user_id", {user_id: current_user.id}).order("id DESC")
    else
      @review_arts = []    
      @approved_articles = []
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    if !current_user.is_student?
      @article.approval_status = Article::APPROVED
    else
      @article.approval_status = Article::IN_REVIEW
    end

    @article.reviewer1_id = nil
    @article.reviewer2_id = nil
    @article.reviewer3_id = nil
  
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approve
    if @article.reviewer1_id == nil
      @article.reviewer1_id = current_user.id
    elsif @article.reviewer2_id == nil
      @article.reviewer2_id = current_user.id
    elsif @article.reviewer3_id == nil
      @article.reviewer3_id = current_user.id
      @article.approval_status = Article::APPROVED
      ArticleApprovalMailer.with(user: current_user, status: Article::APPROVED, article: @article).approval_status.deliver_later
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path, notice: "Article Approved." }
        format.json { render :show, status: :approved, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end 
    end
  end

  def reject
    if @article.reviewer1_id == nil
      @article.reviewer1_id = current_user.id
    elsif @article.reviewer2_id == nil
      @article.reviewer2_id = current_user.id
    elsif @article.reviewer3_id == nil
      @article.reviewer3_id = current_user.id
    end
    @article.approval_status = Article::REJECTED

    respond_to do |format|
      if @article.save
        ArticleApprovalMailer.with(user: current_user, status: Article::REJECTED, article: @article, message: params[:reason]).approval_status.deliver_later
        format.html { redirect_to articles_path, notice: "Article Rejected." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end 
    end
  end

  def search
    if params[:id].empty?
      @articles = Article.where("approval_status = ? and title like ?", Article::APPROVED, "%#{params[:title]}%".upcase!).order("id DESC")
    else
      @articles = Article.where("approval_status = ? and id = ?", Article::APPROVED, params[:id][1..]).order("id DESC")
    end

    if @articles.empty?
      redirect_to articles_path, notice: "Article Not Found."
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def authrize_access
      if current_user.is_student?
        raise 'Unauthorized' unless (['index', 'new', 'create', 'show', 'search'].include?(params[:action]))
        if @article.present?
          raise 'Unauthorized' if ((@article.user != current_user) && (@article.approval_status != Article::APPROVED))
        end 
      else
        if ['edit', 'update', 'destroy'].include?(params[:action])
          raise 'Unauthorized' unless @article.user == current_user
        elsif ['approve', 'reject'].include?(params[:action])
          raise 'Unauthorized' unless @article.user.is_student?
          if params[:action] == 'approve'
            raise 'Unauthorized' if (@article.approval_status == Article::APPROVED)
          elsif params[:action] == 'reject'
            raise 'Unauthorized' if (@article.approval_status == Article::REJECTED)
          end
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :keywords, :approval_status, :reviewer1_id, :reviewer2_id, :reviewer3_id, :content, :user_id)
    end
end

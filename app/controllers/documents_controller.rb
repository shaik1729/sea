class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: %i[ show edit update destroy approve reject]
  before_action :authrize_access


  # GET /documents or /documents.json
  def index
    @documents = current_user.documents.all.order("id DESC")
    if !current_user.is_student?
      @review_docs = Document.where("approved_status = :in_review AND (reviewer1_id IS NULL OR reviewer1_id != :user_id ) AND (reviewer2_id IS NULL OR reviewer2_id != :user_id) AND (reviewer3_id IS NULL OR reviewer3_id != :user_id)", {in_review: Document::IN_REVIEW, user_id: current_user.id}).order("id DESC")
      @approved_documents = Document.where("reviewer1_id = :user_id OR reviewer2_id = :user_id OR reviewer3_id = :user_id", {user_id: current_user.id}).order("id DESC")
    else
      @review_docs = []    
      @approved_documents = []

    end
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)
    
    if !current_user.is_student?
      @document.approved_status = Document::APPROVED
    else
      @document.approved_status = Document::IN_REVIEW
    end

    @document.reviewer1_id = nil
    @document.reviewer2_id = nil
    @document.reviewer3_id = nil

    respond_to do |format|
      if @document.save
        format.html { redirect_to document_url(@document), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to document_url(@document), notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approve
    if @document.reviewer1_id == nil
      @document.reviewer1_id = current_user.id
    elsif @document.reviewer2_id == nil
      @document.reviewer2_id = current_user.id
    elsif @document.reviewer3_id == nil
      @document.reviewer3_id = current_user.id
      @document.approved_status = Document::APPROVED
      DocumentApprovalMailer.with(user: current_user, status: Document::APPROVED, document: @document).approval_status.deliver_later
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_path, notice: "Document Approved." }
        format.json { render :show, status: :approved, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end 
    end
  end

  def reject
    if @document.reviewer1_id == nil
      @document.reviewer1_id = current_user.id
    elsif @document.reviewer2_id == nil
      @document.reviewer2_id = current_user.id
    elsif @document.reviewer3_id == nil
      @document.reviewer3_id = current_user.id
    end
    @document.approved_status = Document::REJECTED

    respond_to do |format|
      if @document.save
        DocumentApprovalMailer.with(user: current_user, status: Document::REJECTED, document: @document, message: params[:reason]).approval_status.deliver_later
        @document.destroy
        format.html { redirect_to documents_path, notice: "Document Rejected." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end 
    end
  end

  def search
    if params[:id].empty?
      @documents = Document.where("approved_status = ? and title like ?", Document::APPROVED, "%#{params[:title]}%").order("id DESC")
    else
      @documents = Document.where("approved_status = ? and id = ?", Document::APPROVED, params[:id][1..]).order("id DESC")
    end

    if @documents.empty?
      redirect_to documents_path, notice: "Document Not Found."
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    def authrize_access
      if current_user.is_student?
        raise 'Unauthorized' unless (['index', 'new', 'create', 'show', 'search'].include?(params[:action]))
        if @document.present?
          raise 'Unauthorized' if ((@document.user != current_user) && (@document.approved_status != Document::APPROVED))
        end 
      else
        if ['edit', 'update', 'destroy'].include?(params[:action])
          raise 'Unauthorized' unless @document.user == current_user
        elsif ['approve', 'reject'].include?(params[:action])
          raise 'Unauthorized' unless @document.user.is_student?
          if params[:action] == 'approve'
            raise 'Unauthorized' if (@document.approved_status == Document::APPROVED)
          elsif params[:action] == 'reject'
            raise 'Unauthorized' if (@document.approved_status == Document::REJECTED)
          end
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:title, :keywords, :content, :approved_status, :reviewer1_id, :reviewer2_id, :reviewer3_id, :user_id)
    end
end

class CommentsController < ApplicationController
    before_action :find_commentable, only: :create

    def new
      @comment = Comment.new
    end

    def create
        @commentable.comments.build(comment_params)
        if @commentable.save
            redirect_to request.referrer, notice: "comment added"
        end
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end

    def find_commentable
      if params[:comment_id]
        @commentable = Comment.find_by_id(params[:comment_id])
      elsif params[:document_id]
        @commentable = Document.find_by_id(params[:document_id])
      elsif params[:article_id]
        @commentable = Article.find_by_id(params[:article_id])
      end
    end

end

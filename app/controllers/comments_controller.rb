class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def post_index
    comments = Comment.all.where(post_id: params[:id]).order(created_at: :desc)
    render json: comments, status: :ok
  end

  def create
    new_comment = Comment.create(comment_params)
    render json: new_comment, status: :ok
  end

  def destroy
    deleted_comment = Comment.find(params[:com_id])
    if current_user.id == deleted_comment.user_id || current_user.admin
      deleted_comment.destroy
      render json: deleted_comment, status: :ok
    else
      render status:403
    end
  end

  private
  def comment_params
    new_comment = params.require(:comment).permit(:body, :parent_id)
    new_comment['post_id'] = params[:id]
    new_comment['user_id'] = current_user.id
    new_comment
  end
end

class SavedPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    saved_posts = SavedPost.all.where(user_id: current_user.id).order(created_at: :desc)
    saved_posts = saved_posts.map {|saved_post|
      post = saved_post.post
      {id:saved_post.id, post: {id:post.id, title:post.title}}
    }
    render json: saved_posts, status: :ok
  end

  def create
    post = Post.find(params[:post_id])
    already_saved = SavedPost.all.where(post_id: params[:post_id], user_id: current_user.id)
    if post.user_id == current_user.id
      render status:404
    elsif already_saved != []
      render status:404
    else
      new_saved_post = SavedPost.create(saved_post_params)
      render json: new_saved_post, status: :ok
    end
  end

  def destroy
    deleted_saved_post = SavedPost.find(params[:id])
    if current_user.id == deleted_saved_post.user_id || current_user.admin
      deleted_saved_post.destroy
      render json: deleted_saved_post, status: :ok
    else
      render status:403
    end
  end


  private
  def saved_post_params
    new_saved_post = params.permit(:post_id)
    new_saved_post['user_id'] = current_user.id
    new_saved_post
  end
end

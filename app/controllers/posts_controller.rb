class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    posts = SearchedPostQuery.new(search_params).all
    posts = posts.map { | post |
      user = post.user
      categories = post.categories
      {id:post.id, title:post.title, excerpt:post.excerpt, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}, categories:categories}
    }
    render json: posts
  end

  def detail
    post = Post.find(params[:id])
    user = post.user
    render json: {id:post.id, title:post.title, excerpt:post.excerpt, content:post.content, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}}
  end

  def create
    new_post = Post.new(post_params)
    params['post']['categories'].each do |el|
      new_post.categories << Category.find(el)
    end
    new_post.save
    render json: new_post, status: :ok
  end

  def destroy
    deleted_post = Post.find(params[:post_id])
    if current_user.id == deleted_post.user_id || current_user.admin
      deleted_post.destroy
      render json: deleted_post, status: :ok
    else
      render status:403
    end
  end

  private
  def post_params
    new_post = params.require(:post).permit(:title, :excerpt, :content, :categories)
    new_post.delete('categories')
    new_post['user_id'] = current_user.id
    new_post
  end

  def search_params
    params.slice( :search)
  end
end

class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    posts = SearchedPostQuery.new(search_params).all
    posts = posts.map { | post |
      user = post.user
      {id:post.id, title:post.title, excerpt:post.excerpt, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}}
    }
    render json: posts
  end

  def detail
    post = Post.find(params[:id])
    user = post.user
    render json: {id:post.id, title:post.title, excerpt:post.excerpt, content:post.content, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}}
  end

  def create
    new_post = Post.create(post_params)
    render json: new_post, status: :ok
  end

  private
  def post_params
    new_post = params.require(:post).permit(:title, :excerpt, :content)
    new_post['user_id'] = current_user.id
    new_post
  end

  def search_params
    params.slice( :search)
  end
end

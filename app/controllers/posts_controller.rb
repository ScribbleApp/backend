class PostsController < ApplicationController

  def index
    posts = Post.all.order(:created_at)
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

end

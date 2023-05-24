class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def index
    posts = SearchedPostQuery.new(search_params).all
    posts = posts.map { | post |
      post_with_img = PostSerializer.new(post).serializable_hash[:data][:attributes]
      categories = post.categories
      if params[:categories] != nil
        searched_categories = categories.map {|el| el.name}
        if params[:categories].split(",").all? { |e| searched_categories.include?(e) }

          # {id:post.id, title:post.title, excerpt:post.excerpt, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}, categories:categories}
          post_with_img
        end
      else
        # {id:post.id, title:post.title, excerpt:post.excerpt, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}, categories:categories}
        post_with_img
      end
    }
    render json: posts.select { |el| el != nil}, status: :ok
  end

  # def detail
  #   post = Post.find(params[:id])
  #   user = post.user
  #   render json: {id:post.id, title:post.title, excerpt:post.excerpt, content:post.content, createdAt:post.created_at, user:{id:user.id, email:user.email, name:user.name}, categories: post.categories}
  # end

  def detail
    @post = Post.find(params[:id])
    @post = PostSerializer.new(@post).serializable_hash[:data][:attributes]
    render json: @post
  end

  def create
    new_post = Post.new(post_params)
    params['categories'].split(",").each do |el|
      new_post.categories << Category.find(el)
    end
    new_post.save
    render json: new_post, status: :ok
  end

  def destroy
    deleted_post = Post.find(params[:id])
    if current_user.id == deleted_post.user_id || current_user.admin
      deleted_post.destroy
      render json: deleted_post, status: :ok
    else
      render status:403
    end
  end

  private
  def post_params
    # .require(:post)

    new_post = params.permit(:title, :excerpt, :content, :categories, :image)
    new_post.delete('categories')
    new_post['user_id'] = current_user.id
    new_post
  end

  def search_params
    params.slice( :search)
  end
end

class UsersController < ApplicationController 
  def index
    users = User.all.order(:created_at)
    users = users.map {|user| {id: user.id, name: user.name, email: user.email, admin: user.admin, createdAt: user.created_at}}
    render json: users
  end

  def detail
    user = User.find(params[:id])
    render json: {id: user.id, email: user.email, admin: user.admin, createdAt: user.created_at, posts: user.posts}
  end
end

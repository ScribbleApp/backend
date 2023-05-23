class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    categories = Category.all.order(name: :desc)
    render json: categories
  end

  def create
    if current_user.admin
      new_category = Category.create(name: params[:name])
      render json: new_category, status: :ok
    else
      render status:403
    end
  end

  def destroy
    if current_user.admin
      deleted_category = Category.find(params[:id]).destroy
      render json: deleted_category, status: :ok
    else
      render status:403
    end
  end

end

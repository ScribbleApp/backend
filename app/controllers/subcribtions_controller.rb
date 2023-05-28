class SubcribtionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def subscriptions
    subscriptions = Subscribtion.where(subscriber_id: params[:id]).includes(:user)
    subscriptions = subscriptions.map { | subscription |
      user = subscription.user
      {id:subscription.id, userId:user.id, email:user.email}
    }
    render json: subscriptions, status: :ok
  end

  def subscribers
    subscribers = Subscribtion.where(user_id: params[:id])

    users = subscribers.map { |el| el.subscriber_id }
    users = "(" + users.join(",") + ")"
    users = ActiveRecord::Base.connection.exec_query("SELECT * FROM users WHERE users.id in #{users}")

    subscribers = subscribers.map { | subscriber |
      element = ""
      users.map { |user|
        if subscriber.subscriber_id == user["id"]
          element = {id:subscriber.id, userId:user["id"], email:user["email"]}
        end
      }
      element
    }

    # subscribers = subscribers.map { | subscriber |
    #   user = User.find(subscriber.subscriber_id)
    #   {id:subscriber.id, userId:user.id, email:user.email}
    # }
    render json: subscribers, status: :ok
  end

  def create
    already_saved = Subscribtion.all.where(subscriber_id: current_user.id, user_id: params[:user_id])
    if already_saved != []
      render status:400
    elsif params[:user_id] == current_user.id
      render status:400
    else
      new_subscription = Subscribtion.create(subscription_params)
      render json: new_subscription, status: :ok
    end
  end

  def destroy
    deleted_subscription = Subscribtion.find(params[:id])
    if current_user.id == deleted_subscription.subscriber_id
      deleted_subscription.destroy
      render json: deleted_subscription, status: :ok
    else
      render status:403
    end
  end

  private
  def subscription_params
    new_subscription = params.permit(:user_id)
    new_subscription['subscriber_id'] = current_user.id
    new_subscription
  end
end

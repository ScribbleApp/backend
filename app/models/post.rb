class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :categories
  has_one_attached :image

  scope :by_title, ->() {order title: :asc}
  scope :nothing, ->() {order created_at: :desc}

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end

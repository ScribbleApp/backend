class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :categories

  scope :by_title, ->() {order title: :asc}
  scope :nothing, ->() {order created_at: :desc}

end

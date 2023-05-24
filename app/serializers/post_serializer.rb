class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :excerpt, :content, :created_at, :image_url, :user, :categories
end

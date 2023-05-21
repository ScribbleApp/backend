# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
      

users = User.all
if users.empty? 
  User.create!(name: "admin_user", password: "password", email: "admin@g.com", admin: true)
end

posts = Post.all
if posts.empty?
  user_rel = User.find_by(id: 1)
  Post.create!(title: "test post title 1", excerpt: "test post excerpt 1", content: "<p>text post content 1</p>", user_id: user_rel.id)
end

comments = Comment.all
if comments.empty?
  user_rel = User.first
  post_rel = Post.first
  
  Comment.create(body: "test comment, no parent", user_id: user_rel.id, post_id: post_rel.id)
else 
  comment_rel = Comment.first
  user_rel = User.first
  post_rel = Post.first
  Comment.create(body: "text child comment", user_id: user_rel.id, post_id: post_rel.id, parent_id: comment_rel.id)
end

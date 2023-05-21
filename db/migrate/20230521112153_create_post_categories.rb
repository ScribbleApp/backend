class CreatePostCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_categories do |t|
      t.references :post
      t.references :category
      t.timestamps
    end
  end
end

class CreateSavedPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_posts do |t|
      t.references :user, null: false
      t.references :post, null: false

      t.timestamps
    end
  end
end

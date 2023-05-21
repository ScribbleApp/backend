class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, unique: true, null: false
      t.string :excerpt, null: false
      t.text :content, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end

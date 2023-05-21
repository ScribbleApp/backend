class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :users, null: false
      t.references :posts, null: false
      
      t.timestamps 
    end

    add_column :comments, :parent_id, :integer, null: true, index: true
    add_foreign_key :comments, :comments, column: :parent_id
  end
end

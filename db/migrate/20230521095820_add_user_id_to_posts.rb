class AddUserIdToPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :user_id
    add_reference :posts, :user, index: true
  end
end

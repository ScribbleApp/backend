class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role
    add_column :users, :name, :string
  end
end

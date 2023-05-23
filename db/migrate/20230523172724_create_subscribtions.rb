class CreateSubscribtions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscribtions do |t|
      t.references :subscriber,  null: false, foreign_key: {to_table: :users}
      t.references :user, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end

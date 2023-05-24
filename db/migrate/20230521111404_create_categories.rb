class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, unique: true, null: false, default: ""

      t.timestamps
    end
  end
end

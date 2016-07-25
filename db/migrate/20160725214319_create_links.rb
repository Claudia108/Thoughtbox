class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.integer :read, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

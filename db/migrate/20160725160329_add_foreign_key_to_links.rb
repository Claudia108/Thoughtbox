class AddForeignKeyToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :user, foreign_key: true
  end
end

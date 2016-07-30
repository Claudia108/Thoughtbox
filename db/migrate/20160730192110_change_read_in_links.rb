class ChangeReadInLinks < ActiveRecord::Migration
  def change
    remove_column :links, :read, :integer, default: 0
    add_column :links, :read, :boolean, default: false
  end
end

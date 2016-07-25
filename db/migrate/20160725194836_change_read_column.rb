class ChangeReadColumn < ActiveRecord::Migration
  def change
    remove_column :links, :read, :string, default: 0
    add_column :links, :read, :integer, default: 0
  end
end

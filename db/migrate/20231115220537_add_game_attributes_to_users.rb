class AddGameAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :quarters, :integer
    add_column :users, :white_dice, :integer
    add_column :users, :points, :integer
  end
end

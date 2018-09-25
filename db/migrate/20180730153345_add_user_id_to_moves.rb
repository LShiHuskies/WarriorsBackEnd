class AddUserIdToMoves < ActiveRecord::Migration[5.2]
  def change
    add_column :moves, :user_id, :integer
  end
end

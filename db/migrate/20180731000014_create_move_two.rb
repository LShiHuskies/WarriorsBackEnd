class CreateMoveTwo < ActiveRecord::Migration[5.2]
  def change
    create_table :move_twos do |t|
      t.integer :top
      t.integer :left
      t.integer :user_id
    end
  end
end

class AddScoresToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :scores, :integer
  end
end

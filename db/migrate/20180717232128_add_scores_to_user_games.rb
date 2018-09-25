class AddScoresToUserGames < ActiveRecord::Migration[5.2]
  def change
    add_column :user_games, :score, :integer
  end
end

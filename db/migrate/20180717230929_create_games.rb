class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name, :default => "Dragon Ball Warriors"
      t.timestamps
    end
  end
end

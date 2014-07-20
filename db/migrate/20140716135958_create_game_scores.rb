class CreateGameScores < ActiveRecord::Migration
  def change
    create_table :game_scores do |t|
      t.integer :points
      t.references :game, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

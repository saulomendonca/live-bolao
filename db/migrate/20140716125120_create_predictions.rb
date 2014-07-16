class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :home_team_goal
      t.integer :away_team_goal
      t.references :game, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

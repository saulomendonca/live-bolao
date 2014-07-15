class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :home_team_goal
      t.integer :away_team_goal
      t.references :game, index: true

      t.timestamps
    end
  end
end

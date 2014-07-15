class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :webservice_id
      t.integer :vippredictor_id
      t.string :status
      t.boolean :complete
      t.integer :weight
      t.date :date
      t.references :away_team, index: true
      t.references :home_team, index: true

      t.timestamps
    end
  end
end

class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :code_fifa
      t.string :code_vippredictor
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end

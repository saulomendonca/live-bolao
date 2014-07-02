class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :image
      t.string :name
      t.integer :vippredictor_id

      t.timestamps
    end
  end
end

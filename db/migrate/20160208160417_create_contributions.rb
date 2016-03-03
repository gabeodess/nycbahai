class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.money :amount, :null => false
      t.date :date
      t.integer :num, :unique => true
      t.string :name
      t.string :fund

      t.timestamps null: false
    end
  end
end

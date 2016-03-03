class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type, :null => false
      t.date :last_update_on, :null => false
      t.jsonb :address, :null => false, :default => '{}'
      t.jsonb :contact, :null => false, :default => '{}'
      t.string :borough
      t.string :neighborhood

      t.timestamps null: false
    end
  end
end

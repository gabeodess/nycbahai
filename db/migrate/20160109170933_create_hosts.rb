class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.belongs_to :activity, index: true, foreign_key: true, :null => false
      t.belongs_to :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

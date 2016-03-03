class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :activity, index: true, foreign_key: true, :null => false
      t.belongs_to :person, index: true, foreign_key: true
      t.boolean :bahai, :null => false, :default => true

      t.timestamps null: false
    end
  end
end

class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.date :declared_on
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.jsonb :address

      t.timestamps null: false
    end
    add_index :people, :address, :using => :gin
  end
end

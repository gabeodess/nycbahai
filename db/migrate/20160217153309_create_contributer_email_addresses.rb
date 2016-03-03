class CreateContributerEmailAddresses < ActiveRecord::Migration
  def change
    create_table :contributer_email_addresses do |t|
      t.string :name, :null => false
      t.string :email, :null => false

      t.timestamps null: false
    end
    add_index :contributer_email_addresses, :name, :unique => true
    add_index :contributer_email_addresses, :email
  end
end

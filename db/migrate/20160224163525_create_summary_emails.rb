class CreateSummaryEmails < ActiveRecord::Migration
  def change
    create_table :summary_emails do |t|
      t.string :contributer
      t.integer :year
      t.datetime :sent_at

      t.timestamps null: false
    end
    add_index :summary_emails, :contributer
    add_index :summary_emails, [:contributer, :year], :unique => true
  end
end

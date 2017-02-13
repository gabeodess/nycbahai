class AddKeyToContributerEmailAddresses < ActiveRecord::Migration[5.0]
  def change
    # Contribution.connection.schema_cache.clear!
    Contribution.reset_column_information
    add_column :contributer_email_addresses, :key, :string
    add_index :contributer_email_addresses, :key, unique: true
    ContributerEmailAddress.find_each do |cea|
      helper = Contribution.new(name: cea.name)
      cea.destroy! and next if ContributerEmailAddress.where(key: helper.key).exists?
      cea.update_columns({
        key: helper.key
      })
    end
    change_column :contributer_email_addresses, :key, :string, null: false
  end
end

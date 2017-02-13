class AddKeyToContributions < ActiveRecord::Migration[5.0]
  def change
    add_column :contributions, :key, :string
    add_index :contributions, :key
    Contribution.select('DISITNCT(name)').pluck(:name).each do |name|
      Contribution.where(name: name).update_all(key: name.parameterize)
    end
    change_column :contributions, :key, :string, null: false
  end
end

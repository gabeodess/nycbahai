class AddPermissionsToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :permissions, :jsonb, :default => '[]', :null => false
    add_index :admin_users, :permissions, :using => :gin
  end
end

ActiveAdmin.register AdminUser do
  permit_params

  permit_params do
    params = [:email, :password, :password_confirmation]
    params.push(:permissions => []) if current_admin_user.permissions.include?('admin_users')
    params
  end

  index do
    selectable_column
    id_column
    column :email
    column :permissions
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      # f.input :password
      # f.input :password_confirmation
      f.input :permissions, :as => :check_boxes, :collection => %w( admin_users contributions ) if current_admin_user.permissions.include?('admin_users')
    end
    f.actions
  end

end

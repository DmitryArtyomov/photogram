ActiveAdmin.register User do
  permit_params :email, :address, :first_name, :last_name, :role
  actions :all, except: [:new, :create, :destroy]

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :address
    column :created_at
    column :updated_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      f.input :role, as: :select, collection: ['user', 'admin'], required: true, include_blank: false, include_hidden: false
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :confirmed_at
      row :unconfirmed_email
      row :first_name
      row :last_name
      row :address
      row :avatar
      row :role
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end

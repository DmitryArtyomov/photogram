ActiveAdmin.register User do
  permit_params :email, :address, :first_name, :last_name
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
    end
    f.actions
  end

end

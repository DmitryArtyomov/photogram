ActiveAdmin.register Comment do
  includes :user, :photo

  permit_params :user, :photo, :text

  index do
    selectable_column
    id_column
    column :user
    column :photo
    column :text
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :photo
  filter :text
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Comment Details" do
      f.input :text
    end
    f.actions
  end
end

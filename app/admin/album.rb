ActiveAdmin.register Album do
  permit_params :name, :description
  includes :user, :tags
  actions :all, except: [:new, :create]

  index do
    selectable_column
    id_column
    column :user
    column :name
    column :description
    column "Tags" do |album|
      album.tags.map do |tag|
        link_to tag.text, admin_tag_path(tag.id)
      end.join(', ').html_safe
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :name
  filter :description
  filter :tags
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Album Details" do
      f.input :name
      f.input :description, input_html: { rows: 5 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :user do |album|
        link_to album.user.display_name, [:admin, album.user]
      end
      row :name
      row :description
      row "Tags" do |album|
        album.tags.map do |tag|
          link_to tag.text, admin_tag_path(tag.id)
        end.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end

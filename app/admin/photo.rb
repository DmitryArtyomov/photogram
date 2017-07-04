ActiveAdmin.register Photo do
  permit_params :description, :tags
  actions :all, except: [:new, :create]
  includes :tags, album: :user

  index do
    selectable_column
    id_column
    column :user do |photo|
      link_to photo.album.user.display_name, [:admin, photo.album.user]
    end
    column :description
    column :album
    column :image do |photo|
      link_to photo.image.url, photo.image.url, target: :_blank
    end

    column "Tags" do |photo|
      photo.tags.map do |tag|
        link_to tag.text, admin_tag_path(tag.id)
      end.join(', ').html_safe
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :album
  filter :tags
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :user do |photo|
        link_to photo.album.user.display_name, [:admin, photo.album.user]
      end
      row :description
      row :album
      row :image do |photo|
        link_to photo.image.url, photo.image.url, target: :_blank
      end
      row "Tags" do |photo|
        photo.tags.map do |tag|
          link_to tag.text, admin_tag_path(tag.id)
        end.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Photo Details" do
      f.input :description, input_html: { rows: 5 }
      f.input :tags
    end
    f.actions
  end
end

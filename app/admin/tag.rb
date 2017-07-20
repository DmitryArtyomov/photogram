ActiveAdmin.register Tag do
  permit_params :text

  index do
    selectable_column
    id_column
    column :text
    column :albums do |tag|
      link_to "Albums with #{tag.text}", admin_albums_path(q: { tags_id_eq: tag.id })
    end
    column :photos do |tag|
      link_to "Photos with #{tag.text}", admin_photos_path(q: { tags_id_eq: tag.id })
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :text
      row :photos
      row :albums do |tag|
        link_to "Albums with #{tag.text}", admin_albums_path(q: { tags_id_eq: tag.id })
      end
      row :photos do |tag|
        link_to "Photos with #{tag.text}", admin_photos_path(q: { tags_id_eq: tag.id })
      end
      row :albums
      row :created_at
    end
    active_admin_comments
  end

  filter :text
  filter :created_at
end

ActiveAdmin.register Tag do
  permit_params :text

  index do
    selectable_column
    id_column
    column :text
    column :photos do |tag|
      link_to "Photos with #{tag.text}", admin_photos_path(q: { tags_id_eq: tag.id })
    end
    column :albums do |tag|
      link_to "Albums with #{tag.text}", admin_albums_path(q: { tags_id_eq: tag.id })
    end
    column :created_at
    column :updated_at
    actions
  end
end

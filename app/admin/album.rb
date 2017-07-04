ActiveAdmin.register Album do
  permit_params :name, :description
  includes :user, :tags

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
end

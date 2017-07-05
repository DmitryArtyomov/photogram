class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :photos_count, :user

  def user
    ActiveModel::SerializableResource.new(object.user)
  end

  def photos_count
    object.photos.size
  end
end

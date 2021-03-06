# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  is_main      :boolean          default(FALSE)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  photos_count :integer          default(0)
#
# Indexes
#
#  index_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#

class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :photos_count, :user

  def user
    ActiveModelSerializers::SerializableResource.new(object.user)
  end
end

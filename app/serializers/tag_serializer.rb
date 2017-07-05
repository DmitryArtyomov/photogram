# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  text           :string(20)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  taggings_count :integer          default(0)
#
# Indexes
#
#  index_tags_on_text  (text) UNIQUE
#

class TagSerializer < ActiveModel::Serializer
  attributes :text, :items_count

  def items_count
    object.taggings_count
  end
end

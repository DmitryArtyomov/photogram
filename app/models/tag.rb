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

class Tag < ApplicationRecord
  include PgSearch

  validates :text, uniqueness: true, format: { with: /\A#[\da-zA-Zа-яА-ЯёЁ]{1,20}\z/,
    message: 'wrong tag format' }

  pg_search_scope :search_by_text, against: :text, using: { tsearch: { prefix: true} }

  has_many :taggings
  has_many :albums, through: :taggings, source: :taggable, source_type: 'Album'
  has_many :photos, through: :taggings, source: :taggable, source_type: 'Photo'

  def display_name
    text
  end
end

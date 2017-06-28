# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  text       :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
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

  has_and_belongs_to_many :albums
  has_and_belongs_to_many :photos

  def display_name
    text
  end
end

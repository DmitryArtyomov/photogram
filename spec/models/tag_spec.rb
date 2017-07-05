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

require 'rails_helper'

RSpec.describe Tag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

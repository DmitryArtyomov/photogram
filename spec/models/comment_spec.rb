# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :string
#  user_id    :integer
#  photo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_photo_id  (photo_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (photo_id => photos.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'attribute validators' do
    subject { build(:comment) }

    include_examples 'empty attribute validation', empty_attribute: nil,     validity: true
    include_examples 'empty attribute validation', empty_attribute: :user,   validity: false
    include_examples 'empty attribute validation', empty_attribute: :text,   validity: false
    include_examples 'empty attribute validation', empty_attribute: :photo,  validity: false

    context 'text' do
      include_examples 'text length validation', length: 0,   validity: false
      include_examples 'text length validation', length: 1,   validity: true
      include_examples 'text length validation', length: 140, validity: true
      include_examples 'text length validation', length: 141, validity: false
    end
  end
end

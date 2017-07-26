# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  description :text
#  image       :string
#  album_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_photos_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id) ON DELETE => cascade
#

require 'rails_helper'

RSpec.describe Photo, type: :model do

  context 'attribute validators' do
    subject { build(:photo) }
    include_examples 'empty attribute validation', empty_attribute: nil,          validity: true
    include_examples 'empty attribute validation', empty_attribute: :description, validity: true
    include_examples 'empty attribute validation', empty_attribute: :album,       validity: false
    include_examples 'empty attribute validation', empty_attribute: :image,       validity: false
  end

  context 'instance methods' do
    subject { create(:photo) }
    describe '#display_name' do
      it 'should return "Photo #id"' do
        expect(subject.display_name).to eq "Photo ##{subject.id}"
      end
    end
  end
end

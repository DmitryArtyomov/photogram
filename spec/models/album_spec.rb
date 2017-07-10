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

require 'rails_helper'

RSpec.describe Album, type: :model do

  context 'attribute validators' do
    subject { build(:album) }
    include_examples 'empty attribute validation', empty_attribute: nil,          validity: true
    include_examples 'empty attribute validation', empty_attribute: :description, validity: true
    include_examples 'empty attribute validation', empty_attribute: :name,        validity: false
    include_examples 'empty attribute validation', empty_attribute: :user,        validity: false
  end

  context 'associations validators' do
    context 'photos' do
      shared_examples 'photos count validation' do |photos_count:, validity:|
        context "#{photos_count} photos" do
          subject { build(:album_with_photos, photos_count: photos_count) }
          it "is #{validity ? '' : 'not '}valid with #{photos_count} photos" do
            expect(subject).send(validity ? "to" : "to_not", be_valid)
          end
        end
      end

      include_examples 'photos count validation', photos_count: 0,  validity: true
      include_examples 'photos count validation', photos_count: 50, validity: true
      include_examples 'photos count validation', photos_count: 51, validity: false
    end
  end
end

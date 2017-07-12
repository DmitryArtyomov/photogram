# == Schema Information
#
# Table name: followerships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_followerships_on_followed_id                  (followed_id)
#  index_followerships_on_follower_id                  (follower_id)
#  index_followerships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id) ON DELETE => cascade
#  fk_rails_...  (follower_id => users.id) ON DELETE => cascade
#

require 'rails_helper'

RSpec.describe Followership, type: :model do
  subject { build(:followership) }

  include_examples 'empty attribute validation', empty_attribute: nil,       validity: true
  include_examples 'empty attribute validation', empty_attribute: :follower, validity: false
  include_examples 'empty attribute validation', empty_attribute: :followed, validity: false

  it 'is not valid when follower is equal to followed' do
    subject.followed = subject.follower
    expect(subject).to_not be_valid
  end

  it 'is not valid if such followership already exists' do
    subject.dup.save
    expect(subject).to_not be_valid
  end
end

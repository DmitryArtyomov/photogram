require 'rails_helper'

RSpec.describe FollowershipsService do
  subject { described_class.new(user) }

  context '#get' do
    context 'user with active followerships' do
      let(:user) { create(:user_following) }

      it 'returns followerships where user is follower' do
        expect(subject.get).to eq(user.active_followerships)
      end
    end

    context 'user without active followerships' do
      let(:user) { create(:user) }

      it 'returns empty collection' do
        expect(subject.get).to eq(user.active_followerships)
      end
    end

    context 'nil user' do
      let(:user) { nil }

      it 'returns empty array' do
        expect(subject.get).to eq([])
      end
    end
  end
end

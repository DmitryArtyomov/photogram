require 'rails_helper'

RSpec.describe Operations::Users::Confirm do
  subject { described_class.new(user) }

  context '#execute' do
    context 'user without albums' do
      let(:user) { create(:user) }

      it 'creates a main album' do
        expect { subject.execute }.to change { user.albums.count }.from(0).to(1)
        expect(user.albums.first.is_main?).to eq(true)
      end
    end

    context 'user with albums' do
      let(:user) { create(:user_with_albums) }

      it 'doesn\'t create an album' do
        expect { subject.execute }.to_not change { user.albums.count }
      end
    end
  end
end

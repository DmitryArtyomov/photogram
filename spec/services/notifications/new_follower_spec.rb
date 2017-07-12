require 'rails_helper'

RSpec.describe Notifications::NewFollower do
  subject { described_class.new(followership) }

  context '#notify' do
    let(:channel) { class_double("NotificationsChannel").as_stubbed_const }
    let(:mailer) { class_double("NotificationsMailer").as_stubbed_const }
    before(:example) { allow(mailer).to receive_message_chain(:follower_notification, :deliver_later) }

    context 'new followership' do
      let(:followership) { create(:followership) }

      it 'sends a notification over ActionCable' do
        expect(channel).to receive(:broadcast_to).with(followership.followed, hash_including(type: 'follower'))

        subject.notify
      end

      it 'sends an email notification' do
        expect(mailer).to receive(:follower_notification).with(followership)
        expect(mailer).to receive_message_chain(:follower_notification, :deliver_later).with(no_args)

        subject.notify
      end
    end
  end
end

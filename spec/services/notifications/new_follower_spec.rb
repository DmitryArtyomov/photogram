require 'rails_helper'

RSpec.describe Notifications::NewFollower do
  subject { described_class.new(followership) }

  describe '#notify' do
    let(:channel) { class_double("NotificationsChannel").as_stubbed_const }
    let(:mailer) { class_double("NotificationsMailer").as_stubbed_const }
    let(:recipient) { subject.followership.followed }
    before(:example) { allow(mailer).to receive_message_chain(:follower_notification, :deliver_later) }

    shared_context 'email follower notifications enabled' do
      before(:example) { recipient.follower_email_notification = true }
    end

    shared_context 'email follower notifications disabled' do
      before(:example) { recipient.follower_email_notification = false }
    end

    context 'new followership' do
      let(:followership) { create(:followership) }

      it 'sends a notification over ActionCable' do
        expect(channel).to receive(:broadcast_to).with(followership.followed, hash_including(type: 'follower'))
        subject.notify
      end

      context 'email notifications enabled' do
        include_context 'email follower notifications enabled' do
          it 'sends an email notification' do
            expect(mailer).to receive(:follower_notification).with(followership)
            expect(mailer).to receive_message_chain(:follower_notification, :deliver_later).with(no_args)
            subject.notify
          end
        end
      end

      context 'email notifications disabled' do
        include_context 'email follower notifications disabled' do
          it 'doesn\'t send an email notification' do
            expect(mailer).to_not receive(:follower_notification).with(followership)
            subject.notify
          end
        end
      end
    end
  end
end

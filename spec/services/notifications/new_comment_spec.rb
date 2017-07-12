require 'rails_helper'

RSpec.describe Notifications::NewComment do
  subject { described_class.new(comment) }

  context '#notify' do
    let(:channel) { class_double("NotificationsChannel").as_stubbed_const }
    let(:mailer) { class_double("NotificationsMailer").as_stubbed_const }
    before(:example) { allow(mailer).to receive_message_chain(:comment_notification, :deliver_later) }

    context 'comment from another user' do
      let(:comment) { create(:comment) }
      it 'sends a notification over ActionCable' do
        expect(channel).to receive(:broadcast_to).with(comment.photo.album.user, hash_including(type: 'comment'))

        subject.notify
      end

      it 'sends an email notification' do
        expect(mailer).to receive(:comment_notification).with(comment)
        expect(mailer).to receive_message_chain(:comment_notification, :deliver_later).with(no_args)

        subject.notify
      end
    end

    context 'comment from photo owner' do
      let(:comment) { create(:comment_by_photo_owner) }
      it 'doesn\'t send a notification over ActionCable' do
        expect(channel).to_not receive(:broadcast_to).with(comment.photo.album.user, hash_including(type: 'comment'))

        subject.notify
      end

      it 'doesn\'t send an email notification' do
        expect(mailer).to_not receive(:comment_notification).with(comment)

        subject.notify
      end
    end
  end
end

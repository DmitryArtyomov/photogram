require 'rails_helper'

RSpec.describe Notifications::NewComment do
  subject { described_class.new(comment) }

  describe '#notify' do
    let(:channel) { class_double("NotificationsChannel").as_stubbed_const }
    let(:mailer) { class_double("NotificationsMailer").as_stubbed_const }
    let(:recipient) { subject.comment.photo.album.user }
    before(:example) { allow(mailer).to receive_message_chain(:comment_notification, :deliver_later) }

    shared_context 'email comment notifications enabled' do
      before(:example) { recipient.comment_email_notificaton = true }
    end

    shared_context 'email comment notifications disabled' do
      before(:example) { recipient.comment_email_notificaton = false }
    end

    context 'comment from another user' do
      let(:comment) { create(:comment) }
      it 'sends a notification over ActionCable' do
        expect(channel).to receive(:broadcast_to).with(comment.photo.album.user, hash_including(type: 'comment'))
        subject.notify
      end

      context 'email notifications enabled' do
        include_context 'email comment notifications enabled' do
          it 'sends an email notification' do
            expect(mailer).to receive(:comment_notification).with(comment)
            expect(mailer).to receive_message_chain(:comment_notification, :deliver_later).with(no_args)
            subject.notify
          end
        end
      end

      context 'email notifications disabled' do
        include_context 'email comment notifications disabled' do
          it 'doesn\'t send an email notification' do
            expect(mailer).to_not receive(:comment_notification).with(comment)
            subject.notify
          end
        end
      end
    end

    context 'comment from photo owner' do
      let(:comment) { create(:comment_by_photo_owner) }
      it 'doesn\'t send a notification over ActionCable' do
        expect(channel).to_not receive(:broadcast_to).with(comment.photo.album.user, hash_including(type: 'comment'))
        subject.notify
      end

      context 'email notifications enabled' do
        include_context 'email comment notifications enabled' do
          it 'doesn\'t send an email notification' do
            expect(mailer).to_not receive(:comment_notification).with(comment)
            subject.notify
          end
        end
      end

      context 'email notifications disabled' do
        include_context 'email comment notifications disabled' do
          it 'doesn\'t send an email notification' do
            expect(mailer).to_not receive(:comment_notification).with(comment)
            subject.notify
          end
        end
      end
    end
  end
end

require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  include Rails.application.routes.url_helpers

  describe '.follower_notification' do
    let(:followership) { create(:followership) }
    let(:follower) { followership.follower }
    let(:recipient) { followership.followed }
    let(:mail) { described_class.follower_notification(followership).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{follower.first_name} #{follower.last_name} is now following you")
    end

    it 'renders the recipient email' do
      expect(mail.to).to eq([recipient.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['notifications@photogram.net'])
    end

    context 'mail body' do
      it 'contains recipient first name' do
        expect(CGI::unescapeHTML(mail.body.encoded)).to match(recipient.first_name)
      end

      it 'contains follower full name' do
        expect(CGI::unescapeHTML(mail.body.encoded)).to match("#{follower.first_name} #{follower.last_name}")
      end

      it 'contains follower profile url' do
        expect(CGI::unescapeHTML(mail.body.encoded))
          .to match(/https?:\/\/[\w\d\.:]+#{Regexp.escape(user_path(follower))}/)
      end
    end
  end

  describe '.comment_notification' do
    let(:comment) { create(:comment) }
    let(:commenter) { comment.user }
    let(:recipient) { comment.photo.album.user }
    let(:mail) { described_class.comment_notification(comment).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{commenter.first_name} #{commenter.last_name} left a comment on your photo")
    end

    it 'renders the recipient email' do
      expect(mail.to).to eq([recipient.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['notifications@photogram.net'])
    end

    context 'mail body' do
      it 'contains recipient first name' do
        expect(CGI::unescapeHTML(mail.body.encoded)).to match(recipient.first_name)
      end

      it 'contains commenter full name' do
        expect(CGI::unescapeHTML(mail.body.encoded)).to match("#{commenter.first_name} #{commenter.last_name}")
      end

      it 'contains commenter profile url' do
        expect(CGI::unescapeHTML(mail.body.encoded))
          .to match(/https?:\/\/[\w\d\.:]+#{Regexp.escape(user_path(commenter))}/)
      end

      it 'contains commented photo url' do
        expect(CGI::unescapeHTML(mail.body.encoded)).to match(
          /https?:\/\/[\w\d\.:]+#{Regexp.escape(user_album_photo_path(recipient, comment.photo.album, comment.photo))}/
        )
      end
    end
  end
end

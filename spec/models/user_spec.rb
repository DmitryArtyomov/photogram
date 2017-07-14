# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  reset_password_token        :string
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  confirmation_token          :string
#  confirmed_at                :datetime
#  confirmation_sent_at        :datetime
#  unconfirmed_email           :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  first_name                  :string           not null
#  last_name                   :string           not null
#  address                     :string
#  avatar                      :string
#  role                        :string           default("user")
#  followers_count             :integer          default(0)
#  follower_email_notification :boolean          default(TRUE)
#  comment_email_notificaton   :boolean          default(TRUE)
#
# Indexes
#
#  index_users_on_confirmation_token        (confirmation_token) UNIQUE
#  index_users_on_email                     (email) UNIQUE
#  index_users_on_last_name_and_first_name  (last_name,first_name)
#  index_users_on_reset_password_token      (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context 'attribute validators' do
    include_examples 'empty attribute validation', empty_attribute: nil,          validity: true
    include_examples 'empty attribute validation', empty_attribute: :avatar,      validity: true
    include_examples 'empty attribute validation', empty_attribute: :first_name,  validity: false
    include_examples 'empty attribute validation', empty_attribute: :last_name,   validity: false
    include_examples 'empty attribute validation', empty_attribute: :email,       validity: false
    include_examples 'empty attribute validation', empty_attribute: :password,    validity: false
  end

  context 'instance methods' do
    context '#display_name' do
      it 'should return first_name and last_name joined by space' do
        expect(subject.display_name).to eq "#{subject.first_name} #{subject.last_name}"
      end
    end
  end
end

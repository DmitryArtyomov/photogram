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

require 'open-uri'

FactoryGirl.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
    address       { Faker::Address.city }
    avatar        { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/avatar.png'), 'image/png') }
    confirmed_at  Date.today
    role          'user'
    follower_email_notification true
    comment_email_notificaton   true

    factory :user_following do
      transient do
        following_count 5
      end

      after(:create) do |user, evaluator|
        user.active_followerships = build_list(:followership, evaluator.following_count, follower: user)
      end
    end

    factory :user_followed do
      transient do
        followed_count 5
      end

      after(:create) do |user, evaluator|
        user.passive_followerships = build_list(:followership, evaluator.followed_count, followed: user)
      end
    end

    factory :user_with_albums do
      transient do
        albums_count 5
      end

      after(:create) do |user, evaluator|
        user.albums = build_list(:album, evaluator.albums_count, user: user)
      end
    end

    factory :admin do
      role 'admin'
    end

    factory :user_not_confirmed do
      confirmed_at nil
    end

    factory :user_no_notifications do
      follower_email_notification false
      comment_email_notificaton   false
    end
  end
end

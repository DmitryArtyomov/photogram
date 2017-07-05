# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string           not null
#  last_name              :string           not null
#  address                :string
#  avatar                 :string
#  role                   :string           default("user")
#  followers_count        :integer          default(0)
#
# Indexes
#
#  index_users_on_confirmation_token        (confirmation_token) UNIQUE
#  index_users_on_email                     (email) UNIQUE
#  index_users_on_last_name_and_first_name  (last_name,first_name)
#  index_users_on_reset_password_token      (reset_password_token) UNIQUE
#

class UserSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :first_name, :last_name, :avatar, :followers

  def avatar
    object.avatar.url || ActionController::Base.helpers.asset_path('noavatar.png')
  end

  def followers
    object.followers_count
  end
end

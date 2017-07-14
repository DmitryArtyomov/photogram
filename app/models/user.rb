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

class User < ApplicationRecord
  include PgSearch

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  validates :first_name, :last_name, presence: true

  mount_uploader :avatar, AvatarUploader

  has_many :albums
  has_many :photos, through: :albums
  has_many :comments


  has_many :active_followerships,  class_name: 'Followership', foreign_key: 'follower_id'
  has_many :passive_followerships, class_name: 'Followership', foreign_key: 'followed_id'

  has_many :followers, through: :passive_followerships, source: :follower
  has_many :following, through: :active_followerships,  source: :followed

  has_many :feed_photos, through: :following, source: :photos

  pg_search_scope :search_by_full_name, against: [:first_name, :last_name], using: { tsearch: { prefix: true } }

  def display_name
    "#{first_name} #{last_name}"
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end

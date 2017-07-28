require 'rails_helper'
require "cancan/matchers"

describe "abilities" do
  subject(:ability) { Ability.new(user) }

  shared_context 'all users' do
    let(:other_user)         { create(:user) }
    let(:other_followership) { create(:followership, follower: other_user) }
    let(:other_album)        { create(:album, user: other_user) }
    let(:other_photo)        { create(:photo, album: other_album) }
    let(:other_self_comment) { create(:comment_by_photo_owner, photo: other_photo) }
    let(:other_user_comment) { create(:comment, photo: other_photo) }

    it { is_expected.to have_abilities([:read, :search], other_user) }
    it { is_expected.to not_have_abilities([:create, :update, :destroy, :create_nested_resource, :read_notifications], other_user) }

    it { is_expected.to have_abilities(:read, other_album) }
    it { is_expected.to not_have_abilities([:create, :update, :destroy], other_album) }

    it { is_expected.to have_abilities(:read, other_photo) }
    it { is_expected.to not_have_abilities([:create, :update, :destroy], other_photo) }

    it { is_expected.to have_abilities(:read, other_followership) }
    it { is_expected.to not_have_abilities([:create, :update, :destroy], other_followership) }

    it { is_expected.to have_abilities(:read, other_self_comment) }
    it { is_expected.to not_have_abilities([:create, :update, :destroy], other_self_comment) }
    it { is_expected.to have_abilities(:read, other_user_comment) }
    it { is_expected.to not_have_abilities([:create, :update, :destroy], other_user_comment) }
  end

  describe "unregistered user" do
    let(:user)               { nil }

    include_context "all users"
    it { is_expected.to not_have_abilities(:create, Followership.new(follower: user)) }
    it { is_expected.to not_have_abilities(:create, Comment.new(user: user, photo: other_photo)) }
  end

  describe "registered user" do
    let(:user)                   { create(:user) }
    let(:album)                  { create(:album, user: user) }
    let(:main_album)             { create(:album, user: user, is_main: true) }
    let(:photo)                  { create(:photo, album: album) }
    let(:self_comment)           { create(:comment_by_photo_owner, photo: photo) }
    let(:other_comment)          { create(:comment, photo: photo) }
    let(:this_comment)           { create(:comment, photo: other_photo, user: user) }
    let(:follow_other_user)      { create(:followership, follower: user, followed: other_user) }
    let(:followed_by_other_user) { create(:followership, followed: user, follower: other_user) }

    include_context "all users"

    it { is_expected.to have_abilities([:read, :update, :create_nested_resource, :read_notifications], user) }
    it { is_expected.to not_have_abilities(:destroy, user) }

    it { is_expected.to have_abilities([:create, :read, :update, :destroy], album) }
    it { is_expected.to have_abilities([:create, :read, :update], main_album) }
    it { is_expected.to not_have_abilities(:destroy, main_album) }

    it { is_expected.to have_abilities([:create, :read, :update, :destroy], photo) }

    it { is_expected.to have_abilities([:read, :create, :destroy], self_comment) }
    it { is_expected.to have_abilities([:read, :create, :destroy], this_comment) }
    it { is_expected.to have_abilities([:read, :destroy], other_comment) }
    it { is_expected.to not_have_abilities(:create, other_comment) }

    it { is_expected.to have_abilities([:read, :create, :destroy], follow_other_user) }
    it { is_expected.to have_abilities(:read, followed_by_other_user) }
    it { is_expected.to not_have_abilities([:create, :destroy], followed_by_other_user) }

    it { is_expected.to not_have_abilities(:create, Followership.new(follower: user, followed: user)) }
  end

  describe "admin" do
    let(:user) { create(:admin) }

    [Album, Comment, Followership, Photo, Tag, User].each do |r|
      it { is_expected.to have_abilities(:manage, r.new) }
    end
  end
end

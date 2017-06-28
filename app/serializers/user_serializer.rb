class UserSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :first_name, :last_name, :avatar

  def avatar
    object.avatar.url || ActionController::Base.helpers.asset_path('noavatar.png')
  end
end

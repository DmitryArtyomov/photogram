class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id
      can [:update], User, id: user.id
      can [:create_nested_resource], User, id: user.id

      can [:create, :update], Album, user_id: user.id
      can [:destroy], Album, user_id: user.id, is_main: false

      can [:create, :update, :destroy], Photo, album: { user_id: user.id }
    end

    can [:read], User
    can [:read], Album
    can [:read], Photo
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id
      can [:update], User, id: user.id
      can [:create_nested_resource], User, id: user.id

      can [:create, :update], Album, user_id: user.id
      can [:destroy], Album, user_id: user.id, is_main: false
    end

    can [:read], User
    can [:read], Album
  end
end

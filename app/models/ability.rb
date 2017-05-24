class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id
      can [:update], User, id: user.id
    end

    can [:read], User
  end
end

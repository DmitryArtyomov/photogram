class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id
      can [:update, :read], User, id: user.id
    end
  end
end

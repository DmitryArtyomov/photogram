class FollowershipsService
  def initialize(user)
    @user = user
  end

  def get
    return [] unless user
    user.active_followerships
  end

  private

  attr_reader :user
end

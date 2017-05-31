class Operations::Users::Confirm
  def initialize(user)
    @user = user
  end

  def execute
    create_main_album
  end

  private

  attr_reader :user

  def create_main_album
    user.albums.create(name: 'Main album', is_main: true) unless user.albums.any?
  end
end

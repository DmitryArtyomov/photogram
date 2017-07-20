class OnlyAdmins < ActiveAdmin::CanCanAdapter
  def authorized?(action, subject = nil)
    return false unless user.role == 'admin'
    super
  end
end

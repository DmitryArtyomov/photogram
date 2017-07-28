class ConfirmationsController < Devise::ConfirmationsController
  def show
    ActiveRecord::Base.transaction do
      super do |user|
        Operations::Users::Confirm.new(user).execute if user.valid?
      end
    end
  end
end

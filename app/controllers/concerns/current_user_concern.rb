module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || GuestUser.new
  end
end

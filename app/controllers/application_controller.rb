class ApplicationController < ActionController::Base
  include Auth0Helper
  before_action :set_current_user
  add_flash_types :info, :error, :warning, :danger, :success

  def set_current_user
    redirect_to(login_path, info: 'Please sign in first.') and return unless session['userinfo']

    Current.user = User.find_by(uid: session.dig('userinfo', 'uid'))
  end

  def admin_only
    return if Current.user.admin?

    flash[:warning] = 'daaa fuq'
    redirect_to root_path
  end
end

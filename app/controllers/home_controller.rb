class HomeController < ApplicationController
  skip_before_action :set_current_user

  def index
    Current.user = User.find_by(uid: session.dig('userinfo', 'uid')) if session['userinfo']
  end
end

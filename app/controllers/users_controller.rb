class UsersController < ApplicationController
  def profile
    @user = User.find_by(uid: current_user[:uid])
  end
end

class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @current_user = session[:userinfo]&.deep_symbolize_keys
  end
end

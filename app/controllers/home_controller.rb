class HomeController < ApplicationController
  def index
    @current_user = session[:userinfo]&.deep_symbolize_keys
  end
end

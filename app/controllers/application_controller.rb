class ApplicationController < ActionController::Base
  include Auth0Helper
  before_action :authenticate_user!
  add_flash_types :info, :error, :warning, :danger, :success
end

class DashboardController < ApplicationController
  include ActiveSupport::NumberHelper
  def index
    @subscriptions = Current.user.subscriptions
  end
end

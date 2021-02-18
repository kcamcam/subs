class DashboardController < ApplicationController
  include ActiveSupport::NumberHelper

  def index
    @subscriptions = Current.user.subscriptions
    @total = @subscriptions.map { |s| s.amount_in(filter_params[:duration]) }.sum
    @totals = @subscriptions.map { |s| [s.brand.name.capitalize, s.amount_in(filter_params[:duration])] }
                            .sort_by { |_key, value| value }
  end

  def filter_params
    params[:duration] = 'months' unless params[:duration]
    params.permit(:duration)
  end
end

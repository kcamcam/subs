module SubscriptionHelper
  # pluralize or singularize unit
  def units(subscription)
    subscription.frequency > 1 ? subscription.unit : subscription.unit.singularize
  end

  # return the frequency & unit as a concatenated string
  def freq(subscription)
    "#{subscription.frequency} #{units(subscription)}"
  end
end

class StripeCheckoutsController < ApplicationController
  def events
    Rails.logger.info "\n\nThis is from the Stripe webhook\n\n"
  end
end

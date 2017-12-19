class ShadowSpotsController < ApplicationController
  def create
    @shadow_spot = ShadowSpot.create(user_params)
  end

  private

  def user_params
    params.require(:shadow_spot).permit(:time, :date)
  end
end

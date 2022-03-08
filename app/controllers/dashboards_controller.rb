class DashboardsController < ApplicationController
  before_action :confirm_admin

  def index
  end

  private

  def confirm_admin
    current_parent.has_role? :admin
  end
end

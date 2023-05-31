class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['Username'], password: ENV['Password']

  def show
  end

end

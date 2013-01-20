class HomeController < ApplicationController

  # GET /
  def index
    @users = User.all
    @entries = current_user.nil? ? [] : current_user.entries
  end

end

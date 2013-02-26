class ProfileController < ApplicationController
  before_filter :authenticate_user!
  
  def backstory
    @entries = current_user.entries
    respond_to do |format|
      format.html { render 'entries/index'}
      format.json { render json: @entries }
    end
  end
  
end

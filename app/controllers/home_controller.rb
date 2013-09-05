class HomeController < ApplicationController
  def index
    @entries = Entry.where(published: true).desc(:created_at).limit(3)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end
end

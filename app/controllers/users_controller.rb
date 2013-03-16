class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    @users = User.all.select{|e| can? :manage, e}
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @entries = @user.entries.all
  end

end

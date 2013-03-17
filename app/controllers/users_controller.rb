class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, except: [:index, :show]
  load_and_authorize_resource except: [:show, :edit]
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
    @entries = @user.entries.all
  end

end

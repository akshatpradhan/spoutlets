class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  load_and_authorize_resource

  helper_method :devise_mapping, :resource_name, :resource_class

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    generated_password = Devise.friendly_token.first(8)
    user = User.create(email: params[:user][:email], password: generated_password)
    if user.persisted?
      UserMailer.welcome_email(user, generated_password).deliver
      sign_in(:user, user)
      redirect_to entries_path, notice: "Welcome! You have signed up successfully."
    else
      redirect_to signup_path, notice: "You must provide a valid email address to register!"
    end
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
    @entries = @user.entries
  end

  private

  def devise_mapping
    Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end
end

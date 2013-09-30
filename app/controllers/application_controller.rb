class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    entries_path if resource.is_a?(User)
  end

  def after_invite_path_for(resource)
    user_path(current_user)
  end

  protected
    def authenticate_inviter!
      authenticate_user!
    end

  private

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, :alert => "Access denied."
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end

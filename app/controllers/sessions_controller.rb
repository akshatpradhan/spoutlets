class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
## Per http://guides.rubyonrails.org/security.html#sessions
## 2.8 Session Fixation – Countermeasure: reset the session after login:
    reset_session
    session[:user_id] = user.id
    user.add_role :admin if User.count == 1 # make the first user an admin
    if user.email.blank?
      redirect_to (request.env['omniauth.origin'] || edit_user_path(user)), :alert => "Please enter your email address." # the origin parameters records the page from which the request to facebook signin has been called, this is used in entries#preview to redirect back after facebook signin
      # TODO: when a guest is creating an entry and has no email recorded in his facebook profile he is redirected to user#edit after facebook signin instead of the preview_entry_path. Maybe you need to highlight his unapproved entries in his profile page or something like that.
    else
      redirect_to (request.env['omniauth.origin'] || root_url), :notice => 'Signed in!'
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end

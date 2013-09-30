class Therapists::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    # You need to implement the method below in your model (e.g. app/models/therapist.rb)
    @therapist = Therapist.find_for_linkedin_oauth(request.env["omniauth.auth"], current_therapist)

    if @therapist.persisted? && @therapist.invitation_accepted?
      sign_in_and_redirect @therapist, :event => :authentication #this will throw if @therapist is not activated
      set_flash_message(:notice, :success, :kind => "Linkedin") if is_navigational_format?
    else
      Therapist.accept_invitation!(invitation_token: @therapist.invitation_token)
      sign_in_and_redirect @therapist, :event => :authentication #this will throw if @therapist is not activated
      set_flash_message(:notice, :success, :kind => "Linkedin") if is_navigational_format?
    end
  end
end

class Therapists::InvitationsController < Devise::InvitationsController
  def edit
    redirect_to therapist_omniauth_authorize_path(:linkedin)
  end
end

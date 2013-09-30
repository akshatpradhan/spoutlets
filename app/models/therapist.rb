class Therapist
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify

  devise :invitable, :registerable, :omniauthable, omniauth_providers: [:linkedin]

  field :provider,               type: String
  field :uid,                    type: String
  field :email,                  type: String, default: ""
  field :name,                   type: String
  field :invitation_token,       type: String
  field :invitation_created_at,  type: Time
  field :invitation_sent_at,     type: Time
  field :invitation_accepted_at, type: Time
  #field :invitation_limit,       type: Integer #NOTE: move this to the user model

  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  index({invitation_token: 1}, {background: true})
  index({invitation_by_id: 1}, {background: true})

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email

  attr_accessible :role_ids, as: :admin
  attr_accessible :provider, :uid, :name, :email

  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
    therapist = Therapist.where(provider: auth["provider"], uid: auth["uid"]).first
    unless therapist
      therapist = Therapist.create(
        name:  auth[:info][:name],
        uid:   auth[:uid],
        email: auth[:info][:email]
      )
    end
    therapist
  end

  def self.new_with_session(params, session)
    super.tap do |therapist|
      if data = session["devise.linkedin_data"] && session["devise.linkedin_data"]["extra"]["raw_info"]
        therapist.email = data["email"] if therapist.email.blank?
      end
    end
  end
end

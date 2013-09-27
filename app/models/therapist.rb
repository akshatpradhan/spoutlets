class Therapist
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify

  devise :invitable, :omniauthable

  field :provider,               type: String
  field :uid,                    type: String
  field :email,                  type: String, default: ""
  field :name,                   type: String
  field :invitation_token,       type: String
  field :invitation_created_at,  type: Time
  field :invitation_sent_at,     type: Time
  field :invitation_accepted_at, type: Time
  field :invitation_limit,       type: Integer

  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  index({invitation_token: 1}, {background: true})
  index({invitation_by_id: 1}, {background: true})

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email

  attr_accessible :role_ids, as: :admin
  attr_accessible :provider, :uid, :name, :email
end

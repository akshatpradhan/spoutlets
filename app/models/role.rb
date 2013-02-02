class Role
  include Mongoid::Document
  
  belongs_to :resource, polymorphic: true
  has_and_belongs_to_many :users
  
  field :name, type: String
  index({
      name: 1,
      }, {unique: true})
  index({
      name: 1,
      resource_type: 1,
      resource_id: 1,
      }, {unique: true})
  
  scopify
end

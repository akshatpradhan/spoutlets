class Entry
  include Mongoid::Document
  field :title,            type: String
  field :content,          type: String
  field :happiness_level,  type: String
  field :anxiety_level,    type: String
  field :irritation_level, type: String
  field :category,         type: String
  field :published,        type: Boolean
  belongs_to :user
end

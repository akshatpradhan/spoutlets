class Entry
  include Mongoid::Document
  field :content, type: String
  field :happiness, type: String
  field :tag, type: String
end

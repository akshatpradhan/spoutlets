class Entry
  include Mongoid::Document
  field :content, type: String
  field :user_id, type: Integer
# Suggested by Akshat:
  belongs_to :user, inverse_of: :entries, autosave: true
end
